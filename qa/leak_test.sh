#!/usr/bin/env bash
set -euo pipefail
: "${STORE_URL:?Set STORE_URL to Commerce preview URL}"
W="$(mktemp -d)"; trap 'rm -rf "$W"' EXIT
curl -fsSL "$STORE_URL" -o "$W/home.html"
python3 - "$STORE_URL" "$W/home.html" "$W" <<'PY'
import sys,re,pathlib,urllib.parse,subprocess
base,home,out=sys.argv[1:];s=pathlib.Path(home).read_text(errors='ignore'); urls={base}
for x in re.findall(r'(?:href|src)="([^"]+)"',s,re.I):
 u=urllib.parse.urljoin(base,x)
 if urllib.parse.urlparse(u).netloc==urllib.parse.urlparse(base).netloc:urls.add(u)
for i,u in enumerate(urls):
 try:subprocess.run(['curl','-fsSL',u,'-o',str(pathlib.Path(out)/str(i))],check=True,timeout=20,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL)
 except Exception:pass
PY
P=("Demo Biopharma BD" "Synthetic Demo Address, Dhaka, Bangladesh" "DEMO-LIC-0001" "Demo Biopharma GJ" "Synthetic Demo Address, Ahmedabad, India" "DEMO-LIC-0002" "Demo Biopharma HP" "Synthetic Demo Address, Shimla, India" "DEMO-LIC-0003" "Site_Master_File" "NODE-BD-01_SMF_dummy.pdf" "NODE-GJ-02_SMF_dummy.pdf" "NODE-HP-03_SMF_dummy.pdf" "Molecule")
fail=0; for p in "${P[@]}"; do if rg -n -i -F -- "$p" "$W"; then echo "LEAK: $p"; fail=1; fi; done
((fail==0)) && echo "No canary found in bounded public crawl." || exit 1

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
P=("Blue Dune Formulations Pvt Ltd" "Plot 18, Pharma Growth Centre" "DL-HIM-2048" "Gujarat Meridian Labs Pvt Ltd" "Survey 42, Sanand Industrial Estate" "DL-GJ-7712" "Himalaya Pine Therapeutics Pvt Ltd" "Unit 6, Kala Amb Industrial Area" "DL-HP-9031" "Metformin" "Amoxicillin" "Paracetamol" "Site_Master_File" "SMF")
fail=0; for p in "${P[@]}"; do if rg -n -i -F -- "$p" "$W"; then echo "LEAK: $p"; fail=1; fi; done
((fail==0)) && echo "No canary found in bounded public crawl." || exit 1

# gh repo clone kei-kusanagi/django_htmx_tailwind
# cd django_htmx_tailwind
asdf local nodejs lts-gallium
asdf local python 3.10.4
python -m venv venv
source ./venv/bin/activate
# fork .
# touch requirements.txt
./venv/bin/python -m pip install --upgrade pip
pip install -r requirements.txt

npm install 
npm install -D postcss postcss-cli
npm install htmx.org
# npx postcss static/css/main.css -o static/css/main.min.css
# cp node_modules/htmx.org/dist/htmx.min.js static/js/htmx.min.js
mkdir static/js

npm run build
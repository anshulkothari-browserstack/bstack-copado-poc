# Simple Robot Framework + BrowserStack SDK

This is a minimal Robot Framework setup with one test case that opens a URL on BrowserStack using BrowserStack SDK.

## Prerequisites
- Python 3.9+
- BrowserStack account

## Setup
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Set BrowserStack credentials
```bash
export BROWSERSTACK_USERNAME="your_username"
export BROWSERSTACK_ACCESS_KEY="your_access_key"
```

The SDK reads these variables through `browserstack.yml`.

## Optional: URL to open
If not provided, default is `https://example.com`.

```bash
export TEST_URL="https://www.example.com"
```

## Run test
```bash
browserstack-sdk robot tests/browserstack_open_url.robot
```

If needed, install/refresh dependencies first:

```bash
pip install -r requirements.txt
```

Robot reports are generated as:
- `report.html`
- `log.html`
- `output.xml`

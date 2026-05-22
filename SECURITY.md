# Security Policy

## Supported versions

| Version | Supported |
|---|---|
| Unreleased (pre-1.0) | Yes |

## Reporting a vulnerability

**Do NOT open a public GitHub issue for security vulnerabilities.**

Email `fighters-legacy@mkz.io` with:
- A description of the vulnerability
- Steps to reproduce
- Potential impact
- Any suggested mitigations

**Response timeline:**
- 48 hours: acknowledgement
- 7 days: initial assessment and severity classification
- Coordinated disclosure once a fix is available

## Scope

In scope for this repository:
- Buffer overflows or memory corruption in FA format parsers (`*.LIB`, `*.PIC`, `*.PAL`, `*.FLT`, `*.SHP`)
- Path traversal or arbitrary file access via asset loading
- Remote code execution via crafted asset files

Out of scope:
- Vulnerabilities in fighter-legacy engine core (report to the fighters-legacy repo)
- Issues requiring possession of a modified or pirated FA installation

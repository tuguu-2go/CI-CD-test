#!/bin/bash
cat << 'EOF' > results.sarif
{
  "$schema": "https://raw.githubusercontent.com/oasis-tcs/sarif-spec/master/Schemata/sarif-schema-2.1.0.json",
  "version": "2.1.0",
  "runs": [
    {
      "tool": {
        "driver": {
          "name": "AI-Driven API Pentesting Platform ",
          "version": "1.0.0",
          "informationUri": "https://example.com/api-pentesting-platform",
          "rules": [
            {
              "id": "API-SEC-001",
              "name": "Horizontal Privilege Escalation",
              "shortDescription": {
                "text": "API endpoint vulnerable to horizontal privilege escalation "
              },
              "fullDescription": {
                "text": "The API endpoint allows access to resources belonging to other users of the same privilege level."
              },
              "properties": {
                "security-severity": "8.0"
              }
              "help": {
                "text": "The API endpoint allows access to resources belonging to other users of the same privilege level.",
                "markdown": "# Detailed Report\n\n## Vulnerability: Unauthorized Access to Manager's Dashboard\n\n### Overview\n
A critical vulnerability has been discovered where non-managerial employees can access the manager's dashboard, 
potentially exposing sensitive company data and operations.\n\n### Affected File\n
- **File:** `src/app.controller.ts`\n
- **Line Number:** 16 - 21\n\n### Severity\n
- **Security Severity:** High (9.0/10)\n\n### Impact\n
Unauthorized employees could view and potentially alter confidential managerial information, 
leading to data breaches and operational disruptions.\n\n### Steps to Reproduce\n
1. Log in as John Smith (Sales Representative, USER role).\n
2. Navigate to `/app/manager` which should be restricted to MANAGER roles.\n
3. Observe full access to Tom Johnson's (Regional Manager) dashboard and data.\n\n### Suggested Fix\n
- Implement proper role-based access control for the `/app/manager` endpoint.\n
- Ensure only users with MANAGER role can access this sensitive area.\n\n### References\n
- [OWASP Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html)\n\n### Evidence\n\n
- John Smith (USER role) accessed Tom Johnson's managerial dashboard containing sales forecasts and employee performance data.\n\n
![Bypassed](https://i.ibb.co/zH4v6Nr/Bypassed-logo-2-1.png)\n\n### Summary Table\n
| Property             | Value                |\n
|----------------------|----------------------|\n
| **Vulnerability ID** | AUTH001              |\n
| **Severity**         | High                 |\n
| **Precision**        | High                 |\n
| **Tags**             | Security, Authorization |\n\n---\n
For more details on fixing this issue, consult the [full documentation](https://example.com/pentest/AUTH001)."
              },
            },
            {
              "id": "API-SEC-002",
              "name": "Vertical Privilege Escalation",
              "shortDescription": {
                "text": "API endpoint vulnerable to vertical privilege escalation "
              },
              "fullDescription": {
                "text": "The API endpoint allows access to resources or functions intended for higher privilege levels."
              },
              "properties": {
                "security-severity": "9.0"
              }
            }
          ]
        }
      },
      "results": [
        {
          "ruleId": "API-SEC-001",
          "level": "error",
          "message": {
            "text": "Horizontal privilege escalation detected on /app/user endpoint"
          },
          "locations": [
            {
              "physicalLocation": {
                "artifactLocation": {
                  "uri": "src/user/user.controller.ts"
                },
                "region": {
                  "startLine": 9,
                  "endLine": 14
                }
              }
            }
          ],
          "partialFingerprints": {
            "primaryLocationLineHash": "0"
          },
          "properties": {
            "originalPayload": "GET /app/user\nAuthorization: Bearer <valid_token_for_user_100>",
            "modifiedPayload": "GET /app/user\nAuthorization: Bearer <valid_token_for_user_100>",
            "originalResponse": "403 Forbidden",
            "modifiedResponse": "200 OK",
            "recommendation": "Implement strict user-based access controls on the /app/user endpoint. Ensure that users can only access their own data."
          }
        },
        {
          "ruleId": "API-SEC-002",
          "level": "error",
          "message": {
            "text": "Vertical privilege escalation detected on /app/admin endpoint"
          },
          "locations": [
            {
              "physicalLocation": {
                "artifactLocation": {
                  "uri": "src/admin/admin.controller.ts"
                },
                "region": {
                  "startLine": 9,
                  "endLine": 14
                }
              }
            }
          ],
          "partialFingerprints": {
            "primaryLocationLineHash": "0"
          },
          "properties": {
            "originalPayload": "POST /app/admin\nAuthorization: Bearer <valid_token_for_regular_user>\nContent-Type: application/json\n\n{\"username\": \"newuser\", \"email\": \"newuser@example.com\"}",
            "modifiedPayload": "POST /app/admin\nAuthorization: Bearer <valid_token_for_regular_user>\nContent-Type: application/json\n\n{\"username\": \"newuser\", \"email\": \"newuser@example.com\"}",
            "originalResponse": "403 Forbidden",
            "modifiedResponse": "201 Created",
            "recommendation": "Enhance Role-Based Access Control (RBAC) for admin endpoints. Implement strict role checks before allowing access to administrative functions."
          }
        },
        {
          "ruleId": "API-SEC-002",
          "level": "error",
          "message": {
            "text": "Vertical privilege escalation detected on /app/manager endpoint"
          },
          "locations": [
            {
              "physicalLocation": {
                "artifactLocation": {
                  "uri": "src/manager/manager.controller.ts"
                },
                "region": {
                  "startLine": 9,
                  "endLine": 14
                }
              }
            }
          ],
          "partialFingerprints": {
            "primaryLocationLineHash": "0"
          },
          "properties": {
            "originalPayload": "GET /app/manager\nAuthorization: Bearer <valid_token_for_regular_user>",
            "modifiedPayload": "GET /app/manager\nAuthorization: Bearer <valid_token_for_regular_user>",
            "originalResponse": "403 Forbidden",
            "modifiedResponse": "200 OK",
            "recommendation": "Implement proper authorization checks for the /app/manager endpoint. Ensure that only users with admin privileges can access this sensitive information."
          }
        }
      ]
    }
  ]
}
EOF


curl -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Content-Type: application/sarif+json" \
  --data-binary @results.sarif \
  "https://api.github.com/repos/${GITHUB_REPOSITORY}/code-scanning/sarifs"
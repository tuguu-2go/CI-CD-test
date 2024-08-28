#!/bin/bash
cat << 'EOF' > results.sarif
{
  "$schema": "https://raw.githubusercontent.com/oasis-tcs/sarif-spec/master/Schemata/sarif-schema-2.1.0.json",
  "version": "2.1.0",
  "runs": [
    {
      "tool": {
        "driver": {
          "name": "Pentest",
          "informationUri": "https://example.com/pentest",
          "rules": [
            {
              "id": "AUTH001",
              "shortDescription": {
                "text": "Improper Authorization Handling"
              },
              "fullDescription": {
                "text": "This rule checks for improper handling of authorization in the API."
              },
              "help": {
                "text": "Authorization issues can lead to unauthorized access to sensitive information.",
                "markdown": "# Detailed Security Report\n\n## Vulnerability: Unauthorized Access to Manager's Dashboard\n\n### Overview\nA critical vulnerability has been discovered where non-managerial employees can access the manager's dashboard, potentially exposing sensitive company data and operations.\n\n### Affected File\n- **File:** `src/app.controller.ts`\n- **Line Number:** 16 - 21\n\n### Severity\n- **Security Severity:** High (9.0/10)\n\n### Impact\nUnauthorized employees could view and potentially alter confidential managerial information, leading to data breaches and operational disruptions.\n\n### Steps to Reproduce\n1. Log in as John Smith (Sales Representative, USER role).\n2. Navigate to `/app/manager` which should be restricted to MANAGER roles.\n3. Observe full access to Tom Johnson's (Regional Manager) dashboard and data.\n\n### Suggested Fix\n- Implement proper role-based access control for the `/app/manager` endpoint.\n- Ensure only users with MANAGER role can access this sensitive area.\n\n### References\n- [OWASP Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html)\n\n### Evidence\n\n- John Smith (USER role) accessed Tom Johnson's managerial dashboard containing sales forecasts and employee performance data.\n\n![Bypassed](https://i.ibb.co/zH4v6Nr/Bypassed-logo-2-1.png)\n\n### Summary Table\n| Property             | Value                |\n|----------------------|----------------------|\n| **Vulnerability ID** | AUTH001              |\n| **Severity**         | High                 |\n| **Precision**        | High                 |\n| **Tags**             | Security, Authorization |\n\n---\nFor more details on fixing this issue, consult the [full documentation](https://example.com/pentest/AUTH001)."
              },
              "defaultConfiguration": {
                "level": "error"
              },
              "properties": {
                "tags": ["security", "authorization"],
                "precision": "high",
                "security-severity": "9.0"
              }
            }
          ]
        }
      },
      "results": [
        {
          "ruleId": "AUTH001",
          "level": "error",
          "message": {
            "text": "Improper authorization handling detected in API endpoint '/app/manager' allowing unauthorized access."
          },
          "locations": [
            {
              "physicalLocation": {
                "artifactLocation": {
                  "uri": "src/app.controller.ts"
                },
                "region": {
                  "startLine": 16,
                  "startColumn": 1,
                  "endLine": 21
                }
              }
            }
          ]
        }
      ]
    }
  ]
}
EOF

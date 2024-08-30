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
                "markdown": "# Detailed Report\n\n## Vulnerability: Unauthorized Access to other user's Dashboard\n\n### Overview\nA critical vulnerability has been discovered where user can access other user's dashboard, potentially exposing private data.\n\n### Affected File\n- **File:** `src/user/user.controller.ts`\n- **Line Number:** 9 - 14\n\n### Severity\n- **Security Severity:** High (8.0/10)\n\n###Original Payload\n```GET /app/user\nAuthorization: Bearer <valid_token_for_user_100>```\n\n### Modified Payload\n```GET /app/user\nAuthorization: Bearer <valid_token_for_user_100>```\n\n### Original Response\n```403 Forbidden```\n\n### Modified Response\n```200 OK```\n\n### Recommendation\n- Implement proper authorization checks for the /app/user endpoint. Ensure that only users with the same privilege level can access this sensitive information."
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
              },
              "help": {
                "text": "The API endpoint allows access to resources or functions intended for higher privilege levels.",
                "markdown": "# Detailed Report\n\n## Vulnerability: Unauthorized Access to Manager Dashboard\n\n### Overview\nA critical vulnerability has been discovered where a regular user can access the manager dashboard, potentially exposing sensitive information.\n\n### Affected File\n- **File:** `src/manager/manager.controller.ts`\n- **Line Number:** 9 - 14\n\n### Severity\n- **Security Severity:** Critical (9.0/10)\n\n### Original Payload\n```\nGET /app/manager\nAuthorization: Bearer <valid_token_for_regular_user>\n```\n\n### Modified Payload\n```\nGET /app/manager\nAuthorization: Bearer <valid_token_for_regular_user>\n```\n\n### Original Response\n```\n403 Forbidden\n```\n\n### Modified Response\n```\n200 OK\n```\n\n### Recommendation\n- Implement proper authorization checks for the /app/manager endpoint. Ensure that only users with admin privileges can access this sensitive information."
              }
            },
            {
              "id": "API-SEC-003",
              "name": "Vertical Privilege Escalation",
              "shortDescription": {
                "text": "API endpoint vulnerable to vertical privilege escalation "
              },
              "fullDescription": {
                "text": "The API endpoint allows access to resources or functions intended for higher privilege levels."
              },
              "properties": {
                "security-severity": "9.0"
              },
              "help": {
                "text": "The API endpoint allows access to resources or functions intended for higher privilege levels.",
                "markdown": "# Detailed Report\n\n## Vulnerability: Unauthorized Access to Admin Functions\n\n### Overview\nA critical vulnerability has been discovered where a regular user can perform admin functions, potentially compromising system security.\n\n### Affected File\n- **File:** `src/admin/admin.controller.ts`\n- **Line Number:** 9 - 14\n\n### Severity\n- **Security Severity:** Critical (9.0/10)\n\n### Original Payload\n```\nPOST /app/admin\nAuthorization: Bearer <valid_token_for_regular_user>\nContent-Type: application/json\n\n{\"username\": \"newuser\", \"email\": \"newuser@example.com\"}\n```\n\n### Modified Payload\n```\nPOST /app/admin\nAuthorization: Bearer <valid_token_for_regular_user>\nContent-Type: application/json\n\n{\"username\": \"newuser\", \"email\": \"newuser@example.com\"}\n```\n\n### Original Response\n```\n403 Forbidden\n```\n\n### Modified Response\n```\n201 Created\n```\n\n### Recommendation\n- Enhance Role-Based Access Control (RBAC) for admin endpoints. Implement strict role checks before allowing access to administrative functions."
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
          "ruleId": "API-SEC-003",
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
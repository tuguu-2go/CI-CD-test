#!/bin/bash
cat << 'EOF' > results.sarif
{
  "$schema": "https://raw.githubusercontent.com/oasis-tcs/sarif-spec/master/Schemata/sarif-schema-2.1.0.json",
  "version": "2.1.0",
  "runs": [
    {
      "tool": {
        "driver": {
          "name": "AI-Driven API Pentesting Platform",
          "version": "1.0.0",
          "informationUri": "https://example.com/api-pentesting-platform",
          "rules": [
            {
              "id": "API-SEC-001",
              "name": "Horizontal Privilege Escalation",
              "shortDescription": {
                "text": "API endpoint vulnerable to horizontal privilege escalation"
              },
              "fullDescription": {
                "text": "The API endpoint allows access to resources belonging to other users of the same privilege level."
              },
              "properties": {
                "security-severity": "8.0"
              }
            },
            {
              "id": "API-SEC-002",
              "name": "Vertical Privilege Escalation",
              "shortDescription": {
                "text": "API endpoint vulnerable to vertical privilege escalation"
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
            "text": "Horizontal privilege escalation detected on /api/v1/users/101/transactions endpoint"
          },
          "locations": [
            {
              "physicalLocation": {
                "artifactLocation": {
                  "uri": "src/app.controller.ts"
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
            "originalPayload": "GET /api/v1/users/101/transactions\nAuthorization: Bearer <valid_token_for_user_100>",
            "modifiedPayload": "GET /api/v1/users/101/transactions\nAuthorization: Bearer <valid_token_for_user_100>",
            "originalResponse": "403 Forbidden",
            "modifiedResponse": "200 OK",
            "recommendation": "Implement strict user-based access controls on the /api/v1/users/{id}/transactions endpoint. Ensure that users can only access their own transaction data."
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
                  "uri": "src/app.controller.ts"
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
                  "uri": "src/app.controller.ts"
                },
                "region": {
                  "startLine": 16,
                  "endLine": 21
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
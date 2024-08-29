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
          "informationUri": "example.com/api-pentesting-platform",
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
              "helpUri": "example.com/api-security/horizontal-privilege-escalation",
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
              "helpUri": "example.com/api-security/vertical-privilege-escalation",
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
                  "uri": "api.securebank.com/api/v1/users/101/transactions"
                },
                "region": {
                  "startLine": 1,
                  "startColumn": 1,
                  "endLine": 1,
                  "endColumn": 1
                }
              }
            }
          ],
          "partialFingerprints": {
            "primaryLocationLineHash": "0"
          },
          "properties": {
            "originalPayload": "GET /api/v1/users/101/transactions\nAuthorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMDAsInJvbGUiOiJ1c2VyIn0.7pyX2PtMqbpfoGtx2wdP1XTt8bID2N9DpL0yZkjCYb0",
            "modifiedPayload": "GET /api/v1/users/101/transactions\nAuthorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxMDAsInJvbGUiOiJ1c2VyIn0.7pyX2PtMqbpfoGtx2wdP1XTt8bID2N9DpL0yZkjCYb0",
            "originalResponse": "403 Forbidden",
            "modifiedResponse": "200 OK",
            "recommendation": "1. Implement user-based access controls on the /api/v1/users/{id}/transactions endpoint.\n2. Validate the user ID in the JWT token against the requested user ID in the URL.\n3. Use a robust authorization framework like OAuth 2.0 with proper scope definitions.\n4. Implement API gateway solutions to centralize and enhance security controls.\n5. Log and monitor all access attempts, especially failed ones, for auditing purposes."
          }
        },
        {
          "ruleId": "API-SEC-002",
          "level": "error",
          "message": {
            "text": "Vertical privilege escalation detected on /api/v1/admin/create_account endpoint"
          },
          "locations": [
            {
              "physicalLocation": {
                "artifactLocation": {
                  "uri": "api.securebank.com/api/v1/admin/create_account"
                },
                "region": {
                  "startLine": 1,
                  "startColumn": 1,
                  "endLine": 1,
                  "endColumn": 1
                }
              }
            }
          ],
          "partialFingerprints": {
            "primaryLocationLineHash": "0"
          },
          "properties": {
            "originalPayload": "POST /api/v1/admin/create_account\nAuthorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyMDAsInJvbGUiOiJ1c2VyIn0.sF8dveZhvoB8nrUVe1BgqJHXtJ2CMOegxXxVjvaFpKs\nContent-Type: application/json\n\n{\"username\": \"newuser\", \"email\": \"newuser@example.com\", \"role\": \"admin\"}",
            "modifiedPayload": "POST /api/v1/admin/create_account\nAuthorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyMDAsInJvbGUiOiJ1c2VyIn0.sF8dveZhvoB8nrUVe1BgqJHXtJ2CMOegxXxVjvaFpKs\nContent-Type: application/json\n\n{\"username\": \"newuser\", \"email\": \"newuser@example.com\", \"role\": \"admin\"}",
            "originalResponse": "403 Forbidden",
            "modifiedResponse": "201 Created",
            "recommendation": "1. Implement Role-Based Access Control (RBAC) for all admin endpoints.\n2. Verify user roles and permissions server-side before processing any requests.\n3. Use separate endpoints for user and admin operations.\n4. Implement the principle of least privilege for all API operations.\n5. Use strong, short-lived JWT tokens with appropriate claims for authentication.\n6. Implement additional security layers such as IP whitelisting for admin functions.\n7. Conduct regular security audits and penetration testing."
          }
        },
        {
          "ruleId": "API-SEC-002",
          "level": "error",
          "message": {
            "text": "Vertical privilege escalation detected on /api/v1/admin/users endpoint"
          },
          "locations": [
            {
              "physicalLocation": {
                "artifactLocation": {
                  "uri": "api.securebank.com/api/v1/admin/users"
                },
                "region": {
                  "startLine": 1,
                  "startColumn": 1,
                  "endLine": 1,
                  "endColumn": 1
                }
              }
            }
          ],
          "partialFingerprints": {
            "primaryLocationLineHash": "0"
          },
          "properties": {
            "originalPayload": "GET /api/v1/admin/users\nAuthorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjozMDAsInJvbGUiOiJ1c2VyIn0.7f4BtI5pMQjO6PwQvmxT6lzWvYxLPYYGBx2YZ7L9E4Q",
            "modifiedPayload": "GET /api/v1/admin/users\nAuthorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjozMDAsInJvbGUiOiJ1c2VyIn0.7f4BtI5pMQjO6PwQvmxT6lzWvYxLPYYGBx2YZ7L9E4Q",
            "originalResponse": "403 Forbidden",
            "modifiedResponse": "200 OK",
            "recommendation": "1. Implement strict role-based access controls for the /api/v1/admin/users endpoint.\n2. Use a dedicated admin authentication mechanism separate from regular user authentication.\n3. Implement multi-factor authentication (MFA) for admin access.\n4. Use JSON Web Token (JWT) with appropriate claims and validate them server-side.\n5. Implement API request throttling and rate limiting to prevent brute force attacks.\n6. Use HTTPS for all API communications to prevent man-in-the-middle attacks.\n7. Regularly rotate admin access tokens and implement proper token revocation mechanisms.\n8. Log and alert on all admin access attempts, successful or not."
          }
        }
      ]
    }
  ]
}
EOF

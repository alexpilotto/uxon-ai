# Connect a Custom GPT to UXON with Actions

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary

- Use a UXON API key and copy-paste OpenAPI schema to let a Custom GPT read UXON data.
- Use this guide when you want a private Custom GPT to read UXON data through GPT Actions.
- For most day-to-day chat use, the ChatGPT MCP connection is better because it uses OAuth and each teammate signs in as themselves.

## Source

- Help Center: [Connect a Custom GPT to UXON with Actions](https://docs.uxon.ai/en/articles/15995746-connect-a-custom-gpt-to-uxon-with-actions)
- Source collection: Agent workflows and API

## Related UXON Guides

- [Agent command playbook](../../../SKILLS.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)
- [Knowledge base API](../../../skills/knowledge-base.md)

## Article

Use this guide when you want a private Custom GPT to read UXON data through GPT Actions.

For most day-to-day chat use, the ChatGPT MCP connection is better because it uses OAuth and each teammate signs in as themselves. Custom GPT Actions use an API key, so treat the key carefully.

## Before you start

- You need permission to create or edit a GPT in ChatGPT.
- Your ChatGPT workspace must allow Custom GPT Actions and the **uxon.ai** action domain.
- You need a UXON API key from **Account > API Keys**. Use a dedicated key for this GPT.
- If possible, restrict the UXON API key to the specific sub-account this GPT should access.

## Important security note

The schema below exposes read and reporting commands only. The API key is still a credential, so do not paste it into prompts, documents, or shared chats.

If you need create, update, publish, or delete actions from ChatGPT, use the OAuth-based ChatGPT MCP connection instead, or ask UXON support for an expanded setup.

## Create the GPT

1. Open ChatGPT and go to **Explore GPTs**.
2. Select **Create**.
3. Open the **Configure** tab.
4. Give the GPT a clear name, such as **UXON Reporting Assistant**.
5. In **Instructions**, paste the instructions below.

```text
Use UXON only when the user asks about UXON accounts, landing pages, experiments, domains, goals, or reports.
Start with subaccounts.list to find the right siteId unless the user already provided one.
Use only commands exposed in the action schema.
Never guess IDs. If an ID is missing, list the relevant resources and ask the user to choose.
For reports, default to dateRange: last-30-days unless the user asks for a different window.
This GPT is read/reporting only. Do not claim that it can create, update, publish, or delete UXON resources.
```

## Add the Action

1. In the GPT editor, open **Actions**.
2. Select **Create new action**.
3. Set authentication to **API Key**.
4. Set auth type to **Bearer**.
5. Paste your UXON API key. ChatGPT will send it as an **Authorization: Bearer** header.
6. Set the privacy policy URL to **https://uxon.ai/privacy**.
7. Paste the schema below into the schema editor.

## Copy-paste schema

```json
{
  "openapi": "3.0.3",
  "info": {
    "title": "UXON Custom GPT Action",
    "version": "1.0.0",
    "description": "Starter Custom GPT Action schema for reading UXON sub-accounts, landing pages, experiments, domains, goals, and reports through the UXON External API."
  },
  "servers": [
    {
      "url": "https://uxon.ai",
      "description": "UXON production API"
    }
  ],
  "paths": {
    "/api/external/commands": {
      "post": {
        "operationId": "runUxonCommand",
        "summary": "Run an approved UXON command",
        "description": "Run one approved read or reporting command. Start with subaccounts.list to find siteId. Use the exact command and matching input shape shown in the schema.",
        "security": [
          {
            "bearerAuth": []
          }
        ],
        "requestBody": {
          "required": true,
          "content": {
            "application/json": {
              "schema": {
                "oneOf": [
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "subaccounts.list"
                        ],
                        "description": "List accessible UXON sub-accounts."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {}
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "subaccounts.get"
                        ],
                        "description": "Fetch one UXON sub-account by siteId."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          }
                        },
                        "required": [
                          "siteId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "landing_pages.list"
                        ],
                        "description": "List landing pages for one sub-account."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          }
                        },
                        "required": [
                          "siteId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "landing_pages.get"
                        ],
                        "description": "Fetch one landing page by ID."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          },
                          "landingPageId": {
                            "type": "string",
                            "description": "UXON landing page ID."
                          }
                        },
                        "required": [
                          "siteId",
                          "landingPageId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "reports.landing_pages.summary"
                        ],
                        "description": "Get landing page summary reporting for one sub-account."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          },
                          "dateRange": {
                            "type": "string",
                            "enum": [
                              "today",
                              "yesterday",
                              "last-3-days",
                              "last-7-days",
                              "last-14-days",
                              "last-30-days",
                              "last-90-days",
                              "last-365-days",
                              "custom"
                            ],
                            "description": "Optional report window. If omitted, UXON defaults to the last 30 days. Use custom only with from and to."
                          },
                          "from": {
                            "type": "string",
                            "format": "date-time",
                            "description": "Start date/time for custom report windows. Required when dateRange is custom."
                          },
                          "to": {
                            "type": "string",
                            "format": "date-time",
                            "description": "End date/time for custom report windows. Required when dateRange is custom."
                          },
                          "timezone": {
                            "type": "string",
                            "description": "Optional IANA timezone, such as UTC, America/New_York, Europe/London, or Australia/Brisbane."
                          }
                        },
                        "required": [
                          "siteId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "reports.landing_page.details"
                        ],
                        "description": "Get detailed reporting for one landing page."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          },
                          "landingPageId": {
                            "type": "string",
                            "description": "UXON landing page ID."
                          },
                          "dateRange": {
                            "type": "string",
                            "enum": [
                              "today",
                              "yesterday",
                              "last-3-days",
                              "last-7-days",
                              "last-14-days",
                              "last-30-days",
                              "last-90-days",
                              "last-365-days",
                              "custom"
                            ],
                            "description": "Optional report window. If omitted, UXON defaults to the last 30 days. Use custom only with from and to."
                          },
                          "from": {
                            "type": "string",
                            "format": "date-time",
                            "description": "Start date/time for custom report windows. Required when dateRange is custom."
                          },
                          "to": {
                            "type": "string",
                            "format": "date-time",
                            "description": "End date/time for custom report windows. Required when dateRange is custom."
                          },
                          "timezone": {
                            "type": "string",
                            "description": "Optional IANA timezone, such as UTC, America/New_York, Europe/London, or Australia/Brisbane."
                          }
                        },
                        "required": [
                          "siteId",
                          "landingPageId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "experiments.list"
                        ],
                        "description": "List experiments for one sub-account."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          }
                        },
                        "required": [
                          "siteId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "experiments.get"
                        ],
                        "description": "Fetch one experiment by ID."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          },
                          "experimentId": {
                            "type": "string",
                            "description": "UXON experiment ID."
                          }
                        },
                        "required": [
                          "siteId",
                          "experimentId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "reports.experiments.summary"
                        ],
                        "description": "Get experiment summary reporting for one sub-account."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          },
                          "dateRange": {
                            "type": "string",
                            "enum": [
                              "today",
                              "yesterday",
                              "last-3-days",
                              "last-7-days",
                              "last-14-days",
                              "last-30-days",
                              "last-90-days",
                              "last-365-days",
                              "custom"
                            ],
                            "description": "Optional report window. If omitted, UXON defaults to the last 30 days. Use custom only with from and to."
                          },
                          "from": {
                            "type": "string",
                            "format": "date-time",
                            "description": "Start date/time for custom report windows. Required when dateRange is custom."
                          },
                          "to": {
                            "type": "string",
                            "format": "date-time",
                            "description": "End date/time for custom report windows. Required when dateRange is custom."
                          },
                          "timezone": {
                            "type": "string",
                            "description": "Optional IANA timezone, such as UTC, America/New_York, Europe/London, or Australia/Brisbane."
                          }
                        },
                        "required": [
                          "siteId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "domains.list"
                        ],
                        "description": "List domains for one sub-account."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          }
                        },
                        "required": [
                          "siteId"
                        ]
                      }
                    }
                  },
                  {
                    "type": "object",
                    "additionalProperties": false,
                    "required": [
                      "command",
                      "input"
                    ],
                    "properties": {
                      "command": {
                        "type": "string",
                        "enum": [
                          "goals.list"
                        ],
                        "description": "List conversion goals for one sub-account."
                      },
                      "input": {
                        "type": "object",
                        "additionalProperties": false,
                        "properties": {
                          "siteId": {
                            "type": "string",
                            "description": "UXON sub-account/site ID."
                          },
                          "page": {
                            "type": "integer",
                            "minimum": 1,
                            "description": "Optional page number."
                          },
                          "perPage": {
                            "type": "integer",
                            "minimum": 1,
                            "maximum": 100,
                            "description": "Optional page size."
                          }
                        },
                        "required": [
                          "siteId"
                        ]
                      }
                    }
                  }
                ]
              }
            }
          }
        },
        "responses": {
          "200": {
            "description": "Command completed successfully.",
            "content": {
              "application/json": {
                "schema": {
                  "type": "object",
                  "properties": {
                    "command": {
                      "type": "string"
                    },
                    "scope": {
                      "type": "object",
                      "properties": {
                        "teamId": {
                          "type": "string"
                        },
                        "siteId": {
                          "type": "string",
                          "nullable": true
                        }
                      }
                    },
                    "data": {
                      "type": "object",
                      "additionalProperties": true
                    }
                  }
                }
              }
            }
          },
          "400": {
            "description": "Invalid command payload or command input."
          },
          "401": {
            "description": "Missing or invalid UXON API key."
          },
          "403": {
            "description": "External API access is not enabled or the key cannot access the requested resource."
          },
          "429": {
            "description": "Rate limit exceeded."
          }
        }
      }
    }
  },
  "components": {
    "securitySchemes": {
      "bearerAuth": {
        "type": "http",
        "scheme": "bearer",
        "description": "Paste a UXON API key from Account > API Keys. ChatGPT sends it as Authorization: Bearer <key>."
      }
    }
  }
}
```

## Test it

Use the GPT preview panel and try these prompts in order:

1. **Show my UXON sub-accounts.**
2. **List landing pages for this sub-account.**
3. **Show the last 30 days landing page summary for this sub-account.**

If the first prompt returns your UXON sub-accounts, authentication is working. If the second or third prompt fails, check that the GPT is using the exact **siteId** returned by **subaccounts.list**.

## Available commands

| Command | Use it for |
| --- | --- |
| **subaccounts.list** | Find accessible UXON sub-accounts and site IDs. |
| **subaccounts.get** | Inspect one sub-account. |
| **landing_pages.list** | List landing pages for one sub-account. |
| **landing_pages.get** | Inspect one landing page. |
| **reports.landing_pages.summary** | Read landing page performance totals. |
| **reports.landing_page.details** | Read detailed performance for one landing page. |
| **experiments.list** | List experiments. |
| **experiments.get** | Inspect one experiment. |
| **reports.experiments.summary** | Read experiment summary reporting. |
| **domains.list** | List connected domains. |
| **goals.list** | List conversion goals. |

## OpenAI reference

OpenAI setup guide: [Configuring Actions in GPTs](https://help.openai.com/en/articles/9442513-configuring-actions-in-gpts).

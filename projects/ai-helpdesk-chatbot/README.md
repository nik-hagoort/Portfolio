# 🧠 AI-Powered Helpdesk Chatbot (Azure Function)

This is a PowerShell-based Azure Function that uses **Azure OpenAI** to respond to IT helpdesk questions via HTTP API.

## 💡 Features

- Azure Functions (serverless, PowerShell)
- Azure OpenAI (`gpt-3.5-turbo`) integration
- Secure configuration via App Settings
- Easily extendable (AAD auth, frontend, Teams bot, etc.)

## 🧪 Example

**Request:**
```json
{ "question": "How do I fix my VPN?" }
```

**Response:**
```json
{
  "question": "How do I fix my VPN?",
  "answer": "To fix your VPN, restart the client and log in again. If issues continue, contact IT support."
}
```

## 🔧 Tech Stack

- Azure Functions (PowerShell Core)
- Azure OpenAI
- REST API / JSON

## 🔐 Setup (Portal or Bicep)

1. Deploy using Bicep or the Azure Portal
2. Configure these **App Settings**:
   - `AZURE_OPENAI_KEY`
   - `AZURE_OPENAI_ENDPOINT`
   - `AZURE_OPENAI_DEPLOYMENT`

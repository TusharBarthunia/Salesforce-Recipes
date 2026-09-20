# LWC Module Import Demo

This Lightning Web Component demonstrates how Salesforce Lightning UI components can be used through JavaScript module imports.

The example covers different notification and toast components available through module imports, including Alert, Confirm, Prompt, Toast, and Platform Show Toast Event.

---

## What This Example Demonstrates

This component demonstrates the following Salesforce LWC concepts:

- Importing Salesforce base components as JavaScript modules
- Using `lightning/alert`
- Using `lightning/confirm`
- Using `lightning/prompt`
- Using `lightning/toast`
- Using `lightning/platformShowToastEvent`
- Opening modal-based UI components using `.open()`
- Displaying Toast notifications using `.show()`
- Dispatching Salesforce toast events
- Handling asynchronous operations using `async/await`
- Handling values returned from Prompt and Confirm
- Conditional rendering using `lwc:if`
- Basic parent component state management

---

# Component Structure

```text
moduleImportDemo/
│
├── moduleImportDemo.html
├── moduleImportDemo.js
├── moduleImportDemo.css
├── moduleImportDemo.js-meta.xml
└── README.md
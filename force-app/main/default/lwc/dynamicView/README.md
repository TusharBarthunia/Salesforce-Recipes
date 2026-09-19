# LWC Error Boundary

This project demonstrates how to handle unhandled errors in Lightning Web Components (LWC) using the `errorCallback()` lifecycle hook.

The example implements a simple Error Boundary pattern where a parent `dynamicView` component wraps a child `healthView` component. If an unhandled exception occurs inside the child component, the error is caught by the parent component and an `errorView` component is displayed.

---

## Overview

The application has three Lightning Web Components:

- `boundary` – Acts as the Error Boundary and catches unhandled errors.
- `healthView` – Displays the normal/healthy state and contains a button to intentionally trigger an error.
- `errorView` – Displays the error information captured by the Error Boundary.

---

## Component Structure

```text
errorBoundary/
│
├── dynamicView/
│   ├── dynamicView.html
│   ├── dynamicView.js
│   └── dynamicView.js-meta.xml
│
├── healthView/
│   ├── healthView.html
│   └── healthView.js
│
├── errorView/
│   ├── errorView.html
│   └── errorView.js
│
└── README.md
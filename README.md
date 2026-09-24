# Salesforce-Recipes

A practical Salesforce development repository covering **Apex, Lightning Web Components (LWC), Triggers, Asynchronous Apex, Integrations, Flows, and other Salesforce Platform concepts**.

This repository contains small, focused examples that demonstrate individual Salesforce development concepts and real-world implementation patterns.

---

## 📚 Contents

### 1. DynamicView — LWC

**Added:** 19 Sep 2026

Demonstrates the LWC **`errorCallback()` lifecycle hook** and the Error Boundary pattern.

The component demonstrates how an Error Boundary can catch unhandled errors occurring in its child components, including errors triggered from:

- Lifecycle hooks
- Event handlers
- Child component execution

**Related Components:**

- `healthView` — LWC
- `errorView` — LWC

---

### 2. NotificationsAndToastMessages — LWC

**Added:** 20 Sep 2026

Demonstrates the use of Salesforce UI components available through **JavaScript module imports** for displaying notifications, dialogs, and toast messages.

The component demonstrates:

- `lightning/alert`
- `lightning/confirm`
- `lightning/prompt`
- `lightning/toast`
- `lightning/platformShowToastEvent`

**Related Components:**

- None

---

### 3. EventPropagation appEvent — LWC

**Added:** 21 Sep 2026

Demonstrates **Custom Event Propagation in Lightning Web Components (LWC)** using the `CustomEvent` interface and its `bubbles` and `composed` properties.

The component demonstrates:

- Creating and dispatching custom events using `CustomEvent`
- Event propagation through the LWC component hierarchy
- `bubbles` property to control whether an event propagates from the event target to its ancestors
- `composed` property to control whether an event can cross the component's shadow boundary
- Handling custom events in parent components
- Understanding event propagation across nested LWC components

**Related Components:**

- `appEvent` — LWC
- `parentEvent` — LWC
- `childEvent` — LWC

---

### 4. lmsPublisher — LWC

**Added:** 22 Sep 2026

Demonstrates the use of **Lightning Message Service (LMS)** for communication between independent Lightning Web Components.

Here, we published a message from the publisher component and then used LMS to send that message through the `LmsDemo` message channel so the subscriber could receive and display it.

**Related Components:**

- `lmsPublisher` — LWC
- `lmsSubscriber` — LWC
- `LmsDemo` — Message Channel

---

### 5. LDS Cache ldsAccountEditor — LWC

**Added:** 24 Sep 2026

Demonstrates how **Lightning Data Service (LDS)** manages record data through its shared cache.

Here, one component "ldsAccountViewer" is used to view a record and another is used to edit it ldsAccountEditor. When the record is edited through LDS, the updated data is automatically reflected in the view component. Components using a relevant `@wire` adapter receive the new value when LDS detects a record change, so no manual refresh is required.

This demonstrates the difference between LDS-managed data and data returned from Apex, which must be refreshed manually.

**Related Components:**

- `ldsAccountViewer` — LWC
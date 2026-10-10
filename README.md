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

### 4. Lightning Message Service (LMS) lmsPublisher — LWC

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
- `ldsAccountEditor` — LWC

---

### 6. Custom Data Types in Lightning Datatable myDatatable — LWC

**Added:** 26 Sep 2026

Demonstrates how to create custom data types in `lightning-datatable` by extending `LightningDatatable` and defining custom cell templates.

The component uses `typeAttributes` to pass row data into custom cells and `cellAttributes` to customize cell styling and layout. Account records are retrieved from Apex and displayed with custom name and number columns.

**Related Components:**

- `myCustomTypeDatatable` — LWC
- `AccountControllerDatatable` — Apex Class

---

### 7. Wire an Apex Method with Complex Parameters — LWC

**Added:** 27 Sep 2026

Demonstrates how to pass complex parameters to an Apex method using `@wire`. The component builds a reactive object matching the Apex `CustomWrapper` class, containing a string, an integer, and a list, and updates the response when the input values change.

**Related Components:**

- `apexWireMethodWithComplexParams` — LWC
- `ApexTypesController` — Apex Class
- `CustomWrapper` — Apex Class

---

### 8. Apex Continuation Callout — LWC

**Added:** 29 Sep 2026

Demonstrates how to use an **Apex Continuation** to make a long-running HTTP callout without holding the browser request open. The Apex controller starts the callout and processes the response in a callback, while the LWC invokes the method and displays loading, response, and error states.

**Related Components:**

- `continuationDemo` — LWC
- `ContinuationDemoController` — Apex Class

---

### 9. Metadata-Driven Integration Framework — Apex

**Added:** 1 Oct 2026

Introduces a metadata-driven API integration framework pattern that centralizes integration configuration and is designed to support runtime placeholder resolution. This approach can reduce hardcoded payloads and enable new integrations to be onboarded through configuration with minimal code changes. The multipart form builder supports constructing request bodies for file uploads.

Runtime placeholder resolution and several configuration-application paths in `HTTPCalloutService` are currently commented out.

**Related Components:**

- `HTTPCalloutService` — Apex Class
- `HttpCalloutMultipartFormBuilder` — Apex Class
- `CustomMetadataTypeSelector` — Apex Class

---

### 10. Dynamic Interactions — LWC

**Added:** 2 Oct 2026

Demonstrates **Dynamic Interactions in Lightning App Builder** for communication between independent Lightning Web Components.

The component demonstrates:

- Defining a custom event in the LWC metadata configuration
- Dispatching a `CustomEvent` from a source component
- Passing selected Account details through event `detail`
- Configuring Dynamic Interactions in Lightning App Builder
- Passing event data from a source component to target components
- Updating target components dynamically based on the selected Account
- Using `@api` properties in target components to receive interaction data

**Related Components:**

- `dynamicinteractionAccountList` — LWC
- `dynamicinteractionAccountDetail` — LWC

---

### 11. Reactivity Flow Demo — Flow & LWC

**Added:** 3 Oct 2026

Demonstrates **reactivity and data communication between Flow Screen and Lightning Web Components (LWC)**.

The Flow demonstrates communication in both directions:

- **Flow → LWC:** Passing reactive data from Flow to the `colorName` LWC using a public `@api` property exposed through the component's metadata XML.
- **LWC → Flow:** Sending data from the `LwcToFlow` component back to the Flow using the `lightning/flowSupport` module and an `@api` setter.
- Demonstrates how Flow and LWC components can exchange data dynamically during a Screen Flow.
- Demonstrates using public properties to make LWC components configurable and reactive within Flow.

**Flow:**

- `Reactivity Flow Demo` — Screen Flow

**Related Components:**

- `colorName` — LWC
- `LwcToFlow` — LWC

---

### 12. Trigger Handler Framework — Apex

**Added:** 6 Oct 2026

Demonstrates a logicless trigger pattern using a shared `TriggerHandler` base class. A handler extends the base class and calls `run()` from its trigger; the framework dispatches execution to the matching trigger-context method.

The framework supports:

- Context-specific methods for before and after insert, update, and delete, plus after undelete
- Configurable maximum loop counts to help prevent recursive trigger execution
- Bypassing one or more handlers during a transaction, with methods to check or clear bypasses

Reference - (https://github.com/kevinohara80/sfdc-trigger-framework).

**Related Components:**

- `TriggerHandler` — Apex Class

---

### 13. Adding SOSL Queries to Unit Tests — Apex

**Added:** 7 Oct 2026

Demonstrates how to write predictable Apex tests for **Salesforce Object Search Language (SOSL)** queries. SOSL queries return no search results by default during test execution. Use `Test.setFixedSearchResults()` to specify record IDs for subsequent SOSL queries in the test method; calling it again replaces the fixed result set, and passing an empty list results in no matches.

The fixed record IDs are supplied to the SOSL `RETURNING` clause in place of normal search results. Any `WHERE` and `LIMIT` clauses in that clause are still applied to the fixed results. For example, a test can provide both matching and non-matching Accounts and verify that a `WHERE` filter returns only the matching Account. Tests can also set different fixed result lists between SOSL queries or include IDs from multiple objects.

**Related Components:**

- `SoslSearchDemo` — Apex Class
- `SoslSearchDemoTest` — Apex Test Class

---

### 13. LWC Form Factors — FormFactorDemo

**Added:** 8 Oct 2026

Demonstrates how to configure Lightning Web Components for different device form factors using `supportedFormFactors` in the component metadata configuration file.

The component demonstrates:

- Configuring LWC for Desktop (`Large`) and Mobile (`Small`) form factors
- Defining different form-factor support for different Lightning page types
- Configuring an App Page to support Mobile only
- Configuring a Record Page to support Desktop only
- Understanding the difference between page targets and supported form factors

**Configuration:**

- App Page → `Small` (Mobile)
- Record Page → `Large` (Desktop)

**Related Components:**

- `formFactorDemo` — LWC

---

### 14. SeeAllData in Apex Tests — Apex

**Added:** 8 Oct 2026

Demonstrates the use of `@IsTest(SeeAllData=true)` in Apex unit tests and how test methods can access existing records from the Salesforce org.

The test demonstrates:

- Using `SeeAllData=true` to access existing org data in a test method
- Creating additional test data within the test transaction
- Querying existing and newly created records
- Performing DML operations on records accessed through `SeeAllData`
- Understanding that changes made during a test are rolled back after the test execution
- Understanding the difference between data available during test execution and the final state of the org

**Related Components:**

- `SeeAllDataExample` — Apex Test Class

---

### 15. Responsive Layout — LWC

**Added:** 10 Oct 2026

Demonstrates how to create responsive layouts in Lightning Web Components using `lightning-layout` and `lightning-layout-item`.

The component demonstrates:

- Creating responsive layouts using the Salesforce Lightning Grid
- Using `size` to define the layout for larger devices
- Using `small-device-size` for mobile devices
- Displaying content in one column on mobile devices
- Displaying content in two columns on tablets and desktops

**Responsive Configuration:**

- Mobile → `small-device-size="6"` → 1 column
- Tablet/Desktop → `size="12"` → 2 columns

**Related Components:**

- `responsiveLayoutDemo` — LWC

---
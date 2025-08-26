# UI/UX Ruleset

> **Scope**
> These rules apply to every end‑user facing screen, page, or component in this repository.
> They combine heuristic best practices, WCAG 2.2 AA, platform HIGs, and benchmark patterns from Netflix, YouTube, Tesla, Stripe, and other exemplary services.

---

## 🎨 Color Palette (external)

> **WHY**: Centralising colours in a single file ensures dark/light theming, accessibility contrast checks, and future brand updates without code churn.

---

## 🗺️ Layout & Information Density

1. **One primary action per screen** – additional actions are secondary or tertiary.
2. **Decision‑to‑Goal ≤ 2 interactions** *(Pattern ID: DTP‑2C)* when possible.
3. Break forms with **> 6 fields** into a **Stepper wizard** (max 3‑5 steps, fixed‑length progress bar).
4. Minimum touch target **44 × 44 CSS px** (ideal 48 px+) and 8 px spacing.
5. Maintain safe‑area insets (notch / task‑bar) and prefer one‑column layouts on ≤ 768 px viewports.

---

## 🪄 Interaction & Feedback

| Guideline        | Rule                                                                                       |
| ---------------- | ------------------------------------------------------------------------------------------ |
| Loading feedback | Show skeleton/loader if async operation > 100 ms.                                          |
| Optimistic UI    | Use when rollback is trivial; otherwise pessimistic pattern with spinners.                 |
| Error handling   | Provide human‑readable, actionable messages; wrap pages in Error Boundary with retry.      |
| Animation        | Use Framer Motion, easing "ease‑out", duration ≤ 300 ms, respect `prefers-reduced-motion`. |

---

## ♿ Accessibility (WCAG 2.2 AA)

* **Focus indicator** ≥ 2 px outline, contrast ≥ 3 : 1.
* Tab order must follow DOM source order.
* Use ARIA landmarks (`header`, `main`, `nav`, `footer`).
* Provide `alt` for meaningful images; decorative images `role="presentation"`.
* Ensure form fields expose `label`, `aria‑invalid`, `aria‑describedby` as needed.

---

## ⭐ Exemplary Service Patterns

| Pattern ID        | Source       | Prescription                                                     | Why                               |
| ----------------- | ------------ | ---------------------------------------------------------------- | --------------------------------- |
| **NFX‑DTP‑2C**    | Netflix      | From landing to playback ≤ 2 clicks.                             | Reduces decision fatigue.         |
| **NFX‑REM‑GRID**  | Netflix (TV) | Navigation focus must move strictly ⇧⇩⇦⇨ (orthogonal).           | Remote control constraints.       |
| **YTB‑CTL‑48PX**  | YouTube      | Primary media controls ≥ 48 px, bubble style.                    | Minimises mis‑taps.               |
| **YTB‑AB‑ROLL**   | YouTube      | Major UI changes behind feature‑flags & A/B cohorts.             | Data‑driven rollout.              |
| **TSLA‑MIN‑CARD** | Tesla        | Replace clusters of buttons with context‑aware full‑width cards. | Low cognitive load while driving. |
| **TSLA‑OTA‑ITER** | Tesla        | Design components for over‑the‑air UI iteration.                 | Evergreen experience.             |

---

## 📄 Form Design Patterns

| Pattern ID         | Rule                                                                | Reference Services        |
| ------------------ | ------------------------------------------------------------------- | ------------------------- |
| **FORM‑MIN**       | Keep only essential fields per step/screen.                         | Stripe Checkout, Growform |
| **FORM‑MS‑PROG**   | Use 3‑5‑step wizard with fixed progress bar.                        | Growform                  |
| **FORM‑IV‑POS**    | Inline validation shows positive ✓ as green, runs post input.       | Baymard Institute         |
| **FORM‑ERR‑DUAL**  | On submission error: page‑top summary **and** field‑level messages. | GOV.UK                    |
| **FORM‑SIZE‑48PX** | Crucial buttons & inputs ≥ 48 px touch target.                      | Apple Pay                 |
| **FORM‑AUTO**      | Provide `autocomplete` attributes for autofill.                     | Stripe Checkout           |
| **FORM‑SHEET**     | Use modal sheet for critical/interruptive forms.                    | Apple Pay                 |

---

## 🧭 Motivation & Value Messaging

Design every form and input so that **users understand the benefit of completion**. A clear value proposition reduces abandonment and increases data quality.

### Principles

| Principle ID          | Guideline                                                                                                                       | Why                                            |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| **VALUE‑WHY**         | Precede each form (or major section) with a concise statement *"Why we need this information and what you gain"*. 80‑120 chars. | Builds trust, reduces friction.                |
| **VALUE‑DISCLOSURE**  | Pair data requests with privacy/data‑use disclosure links or tooltips.                                                          | Transparency → higher completion.              |
| **VALUE‑GIVEFIRST**   | Whenever possible, **deliver a small payoff before requesting extra fields** (e.g., show instant quote preview).                | Reciprocity effect; user sees immediate value. |
| **VALUE‑PROGRESS**    | Show a progress bar plus **Endowed Progress** (start at ≥ 10 %) to motivate continuation.                                       | Encourages completion (behavioral econ).       |
| **VALUE‑OPTIONAL**    | Mark non‑essential fields as *Optional* and explain added benefit of filling them.                                              | Empowers user choice.                          |
| **VALUE‑MICROCOPY**   | Use action‑benefit phrasing: *“Get personalised offers”* instead of *“Submit”*.                                                 | Links effort to payoff.                        |
| **VALUE‑SOCIALPROOF** | Display trust badges, success counts (<abbr title="e.g. “Over 2 M users completed this step last month”">metrics</abbr>).       | Increases perceived legitimacy.                |

### Checklist (authoritative)

1. Every form header or step includes a **WHY statement** (VALUE‑WHY).
2. For any personal data (email, phone, payment), add data‑use disclosure (VALUE‑DISCLOSURE).
3. If the form spans multiple steps, progress bar starts ≥ 10 % (VALUE‑PROGRESS).
4. Provide an immediate or preview payoff *before* asking for optional advanced fields (VALUE‑GIVEFIRST).
5. Label optional inputs and explain extra benefit (VALUE‑OPTIONAL).
6. Primary CTA text follows *verb + benefit* pattern (VALUE‑MICROCOPY).
7. Include at least one social‑proof element on first step (VALUE‑SOCIALPROOF).

---

## 🔍 Global Checklist (authoritative for AI‑generated code)

1. Use only colour tokens from `src/styles/tokens/colors.ts` – **no hard‑coded hex**.
2. One primary CTA per view.
3. Decision‑to‑Goal ≤ 2 interactions (DTP‑2C).
4. Stepper wizard for > 6 input fields.
5. Touch targets ≥ 44 × 44 px with ≥ 8 px spacing.
6. Show loader/skeleton if wait > 100 ms; optimistic UI requires rollback.
7. Apply inline validation (success & error) and dual error display on submit.
8. **Include WHY statement and benefit‑driven CTA for every form** (VALUE‑WHY & VALUE‑MICROCOPY).
9. All interactive elements have visible text or `aria‑label`.
10. Respect `prefers‑reduced‑motion`; animations ≤ 300 ms.
11. Code must compile without modification under TypeScript strict mode.

---

## component design
* https://atlassian.design/components
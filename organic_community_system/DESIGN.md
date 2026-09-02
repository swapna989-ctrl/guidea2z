---
name: Organic Community System
colors:
  surface: '#fff8f6'
  surface-dim: '#e7d6d2'
  surface-bright: '#fff8f6'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#fff1ed'
  surface-container: '#fceae6'
  surface-container-high: '#f6e4e0'
  surface-container-highest: '#f0dfdb'
  on-surface: '#221a17'
  on-surface-variant: '#55433e'
  inverse-surface: '#382e2c'
  inverse-on-surface: '#ffede9'
  outline: '#88726d'
  outline-variant: '#dbc1bb'
  surface-tint: '#994530'
  primary: '#994530'
  on-primary: '#ffffff'
  primary-container: '#f28b71'
  on-primary-container: '#6c2412'
  inverse-primary: '#ffb4a2'
  secondary: '#446555'
  on-secondary: '#ffffff'
  secondary-container: '#c3e8d4'
  on-secondary-container: '#486a59'
  tertiary: '#4e616e'
  on-tertiary: '#ffffff'
  tertiary-container: '#96a9b8'
  on-tertiary-container: '#2c3e4b'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdad2'
  primary-fixed-dim: '#ffb4a2'
  on-primary-fixed: '#3c0700'
  on-primary-fixed-variant: '#7a2f1b'
  secondary-fixed: '#c6ebd6'
  secondary-fixed-dim: '#aacfbb'
  on-secondary-fixed: '#002115'
  on-secondary-fixed-variant: '#2c4d3e'
  tertiary-fixed: '#d2e5f5'
  tertiary-fixed-dim: '#b6c9d9'
  on-tertiary-fixed: '#0a1d29'
  on-tertiary-fixed-variant: '#374956'
  background: '#fff8f6'
  on-background: '#221a17'
  surface-variant: '#f0dfdb'
typography:
  display-lg:
    fontFamily: Hanken Grotesk
    fontSize: 48px
    fontWeight: '800'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Hanken Grotesk
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Hanken Grotesk
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
  headline-md:
    fontFamily: Hanken Grotesk
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Hanken Grotesk
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Hanken Grotesk
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Hanken Grotesk
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Hanken Grotesk
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.02em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 12px
  md: 24px
  lg: 48px
  xl: 80px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 64px
---

## Brand & Style

The design system is built on a foundation of warmth, inclusivity, and approachable expertise. It balances a modern, clean aesthetic with a "human-first" community feel. The personality is energetic yet grounded, avoiding corporate sterility in favor of soft geometry and organic interactions.

The style is **Modern / Corporate-Soft**, blending the reliability of structured layouts with the friendliness of significant roundedness and a muted, naturalistic color palette. It evokes a sense of trust and discovery, making it ideal for educational platforms, local guides, or community-driven SaaS.

## Colors

The palette is derived directly from the brand's visual identity, focusing on high-contrast accessibility.

- **Primary (Coral):** Used for primary actions, highlights, and critical brand moments. It provides energy and warmth.
- **Secondary (Sage):** Used for supportive elements, success states, and decorative backgrounds. It brings a calming, organic balance.
- **Tertiary (Slate):** The foundational color for text and heavy structural elements. It ensures high legibility and provides a professional anchor to the lighter tones.
- **Neutral:** A range of grays and off-whites (Warm Gray) to maintain the soft, community-focused atmosphere without the harshness of pure black or stark white.

## Typography

The typography uses **Hanken Grotesk** across all roles to maintain a cohesive, modern, and highly legible identity. 

- **Headlines:** Use Bold and ExtraBold weights with tighter letter-spacing to create a strong visual hierarchy.
- **Body:** Set with generous line heights to ensure long-form reading comfort. 
- **Labels:** Use SemiBold weights to remain distinct at smaller sizes. 

For mobile devices, large display headers scale down to prevent excessive line-breaking, while maintaining the same weight for brand recognition.

## Layout & Spacing

This design system utilizes a **Fluid Grid** model based on an 8px baseline. 

- **Desktop:** 12-column grid with 24px gutters and 64px side margins.
- **Tablet:** 8-column grid with 24px gutters and 32px side margins.
- **Mobile:** 4-column grid with 16px gutters and 16px side margins.

Spacing is "generous" by default. Vertical rhythm should favor the `lg` (48px) and `xl` (80px) units between major sections to emphasize the clean, airy brand personality. Padding inside containers should never be less than `md` (24px) for desktop cards.

## Elevation & Depth

Visual hierarchy is established through **Tonal Layers** and **Ambient Shadows**.

- **Z-0 (Base):** The main background uses the off-white `background_hex`.
- **Z-1 (Cards/Surface):** Elevated surfaces use pure white to pop against the background, paired with a very soft, diffused shadow: `box-shadow: 0 4px 20px rgba(59, 77, 90, 0.08)`. The shadow is slightly tinted with the Slate tertiary color to maintain harmony.
- **Z-2 (Overlays/Modals):** These use a deeper shadow with more spread: `box-shadow: 0 12px 40px rgba(59, 77, 90, 0.15)`.

Avoid harsh borders. Instead, use subtle 1px strokes in a very light tint of Slate (e.g., 10% opacity) to define boundaries where shadows are not appropriate.

## Shapes

The design system uses a **Rounded** (Level 2) shape language to reinforce its friendly and community-oriented nature. 

- **Standard Elements:** Buttons, input fields, and small tags use a `0.5rem` (8px) radius.
- **Large Elements:** Cards and containers use `rounded-lg` at `1rem` (16px) or `rounded-xl` at `1.5rem` (24px).
- **Interactive States:** Avoid sharp edges entirely; even focus states should follow the container's radius with a 2px offset.

## Components

- **Buttons:** Primary buttons use the Coral background with white text. Secondary buttons use a Slate outline or Sage background. Always use 16px horizontal and 12px vertical padding as a minimum.
- **Input Fields:** Use a light gray background with a 1px Slate border at 15% opacity. On focus, the border transitions to Primary Coral with a 2px glow.
- **Chips/Badges:** Use the Secondary Sage color at 15% opacity for the background and full-strength Sage for the text to create a soft, accessible look.
- **Cards:** Cards should be borderless with a Z-1 shadow. Titles inside cards should be `headline-md`.
- **Lists:** Use Sage-colored icons or bullets to tie the community theme into data-heavy views.
- **Checkboxes/Radios:** Use the Primary Coral for the selected state to ensure high visibility against white backgrounds.
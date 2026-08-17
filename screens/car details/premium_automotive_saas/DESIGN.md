---
name: Premium Automotive SaaS
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#45464d'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#76777d'
  outline-variant: '#c6c6cd'
  surface-tint: '#565e74'
  primary: '#000000'
  on-primary: '#ffffff'
  primary-container: '#131b2e'
  on-primary-container: '#7c839b'
  inverse-primary: '#bec6e0'
  secondary: '#515f74'
  on-secondary: '#ffffff'
  secondary-container: '#d5e3fd'
  on-secondary-container: '#57657b'
  tertiary: '#000000'
  on-tertiary: '#ffffff'
  tertiary-container: '#340735'
  on-tertiary-container: '#a971a4'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dae2fd'
  primary-fixed-dim: '#bec6e0'
  on-primary-fixed: '#131b2e'
  on-primary-fixed-variant: '#3f465c'
  secondary-fixed: '#d5e3fd'
  secondary-fixed-dim: '#b9c7e0'
  on-secondary-fixed: '#0d1c2f'
  on-secondary-fixed-variant: '#3a485c'
  tertiary-fixed: '#ffd6f7'
  tertiary-fixed-dim: '#f1b2ea'
  on-tertiary-fixed: '#340735'
  on-tertiary-fixed-variant: '#663564'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  title-md:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  gutter: 16px
  margin-mobile: 16px
  margin-desktop: 32px
---

## Brand & Style
The design system is engineered for a premium automotive SaaS platform, blending the precision of high-performance engineering with the clarity of modern data-driven tools. The brand personality is professional, authoritative, and sophisticated, targeting fleet managers and automotive professionals.

The visual direction follows a **Modern Corporate** aesthetic with subtle **Glassmorphism** accents. It prioritizes high information density without sacrificing legibility, drawing inspiration from technical interfaces like Linear and Tesla’s diagnostic displays. The interface evokes trust through structured layouts, intentional whitespace, and a meticulous attention to detail that mirrors the craftsmanship of a luxury vehicle.

## Colors
The palette is rooted in a Deep Automotive Blue (`#0F172A`), providing a stable, institutional foundation. To contrast the heavy tech-focused primary, a refined Lavender (`#E8AAE1`) is used as a sophisticated accent for highlights and active states, moving away from generic tech blues.

- **Primary:** Deep Automotive Blue for text, navigation, and core branding.
- **Accent:** Lavender for focused interactions and unique brand identifiers.
- **Functional:** Success Green and Warning Yellow are calibrated for high legibility against both dark and light surfaces, essential for real-time automotive alerts.
- **Neutral:** A range of Slate grays provides the necessary hierarchy for data-heavy tables and dashboards.

## Typography
The typography system uses **Inter** for English and **Cairo** for Arabic (RTL) to ensure maximum legibility for technical data. The scale is designed to handle complex information hierarchies.

- **Headlines:** Feature tight letter-spacing and semi-bold weights for a modern, "tech-first" look.
- **Data Display:** Uses `body-sm` for table density and `label-caps` for metadata and status indicators.
- **RTL Support:** Cairo is mapped to the same scale as Inter. When the UI switches to Arabic, line-heights are increased by 15% to accommodate the script's descenders while maintaining visual balance.

## Layout & Spacing
The design system employs a **Fluid Grid** model based on a 4px baseline. 

- **Mobile:** A 4-column grid with 16px margins. Components are stacked vertically, with primary actions anchored to the bottom.
- **Desktop:** A 12-column grid. Sidebars are fixed at 280px, while the main content area expands.
- **RTL Reflow:** The layout mirror-flips on the vertical axis. Icons that imply direction (arrows, progress bars) are reversed, while absolute icons (clocks, cars) remain static.

## Elevation & Depth
Depth is achieved through **Tonal Layers** and **Low-Contrast Outlines**.

- **Level 0 (Surface):** The lowest layer, using the primary background color.
- **Level 1 (Card/Section):** Uses a subtle border (1px) in a slightly lighter or darker shade than the surface, depending on the mode.
- **Level 2 (Dropdowns/Modals):** Features a high-diffusion, low-opacity shadow (0px 8px 24px rgba(0,0,0,0.08)) to suggest floating without being heavy.
- **Glassmorphism:** Navigation bars and sticky headers use a backdrop-blur (12px) with a 70% opacity fill of the background color to maintain context during scrolling.

## Shapes
The shape language is **Soft (0.25rem)**, emphasizing a professional and precise character. 

- **Standard Elements:** Inputs, buttons, and smaller widgets use 4px (`rounded-sm`).
- **Containers:** Dashboard cards and modals use 8px (`rounded-lg`) to provide a gentler frame for complex data.
- **Interactive States:** Subtle corner radius increases are avoided to maintain the architectural integrity of the grid.

## Components
Consistent component styling ensures the SaaS remains intuitive and trustworthy.

- **Buttons:** Primary buttons are solid Deep Blue or Lavender. Secondary buttons use the "Ghost" style with a 1px border. All buttons use 14px Semi-Bold text.
- **Input Fields:** Minimalist design with a 1px border and a subtle internal shadow. Focus states are indicated by a Lavender border and a 2px outer ring.
- **Tables:** Optimized for data-heavy automotive logs. Rows use alternating subtle fills (zebra striping) and thin horizontal dividers. Headers are sticky and use `label-caps`.
- **SaaS Widgets:** Financial charts (revenue, maintenance costs) use a combination of the Lavender and Success Green for trend lines. Charts are rendered with zero-tension curves (straight technical lines).
- **Automotive Icons:** Custom line-icons with a 2px stroke weight. All icons are enclosed in a square bounding box to ensure uniform alignment within tables.
- **Status Chips:** Small, rounded-sm badges with low-opacity background fills and high-contrast text for status tracking (e.g., "In Service", "Active").
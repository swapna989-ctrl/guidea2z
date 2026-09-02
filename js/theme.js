/**
 * guidea2z Centralized Theme Management Script
 * Handles light/dark mode persistence, automatic system preference detection,
 * smooth transitions, and cross-tab/cross-frame synchronization.
 */

(function () {
  const THEME_KEY = 'guidea2z_theme';

  // Get current active theme
  function getTheme() {
    const saved = localStorage.getItem(THEME_KEY);
    if (saved === 'dark' || saved === 'light') return saved;
    return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
  }

  // Apply theme to <html> element immediately
  function applyTheme(theme) {
    const root = document.documentElement;
    if (theme === 'dark') {
      root.classList.add('dark');
      root.classList.remove('light');
    } else {
      root.classList.remove('dark');
      root.classList.add('light');
    }
    updateToggleButtons(theme);

    // Notify any listening components
    window.dispatchEvent(new CustomEvent('guidea2z-theme-change', { detail: { theme } }));

    // Notify parent window if in iframe (e.g. preview in index.html)
    if (window.parent && window.parent !== window) {
      window.parent.postMessage({ type: 'guidea2z_theme_change', theme }, '*');
    }
  }

  // Set and persist theme
  function setTheme(theme) {
    localStorage.setItem(THEME_KEY, theme);
    applyTheme(theme);
  }

  // Toggle between light and dark
  function toggleTheme() {
    const next = getTheme() === 'dark' ? 'light' : 'dark';
    setTheme(next);
    return next;
  }

  // Update visual icons/switches on the page
  function updateToggleButtons(theme) {
    // Sun/Moon icon toggle buttons
    document.querySelectorAll('.theme-toggle-btn').forEach(btn => {
      const icon = btn.querySelector('.theme-toggle-icon') || btn.querySelector('.material-symbols-outlined');
      if (icon) {
        icon.textContent = theme === 'dark' ? 'light_mode' : 'dark_mode';
      }
      btn.setAttribute('aria-label', theme === 'dark' ? 'Switch to Light Mode' : 'Switch to Dark Mode');
      btn.setAttribute('title', theme === 'dark' ? 'Switch to Light Mode' : 'Switch to Dark Mode');
    });

    // Text labels in settings
    document.querySelectorAll('.theme-label-text').forEach(el => {
      el.textContent = theme === 'dark' ? 'Dark Mode' : 'Light Mode';
    });

    // Checkbox / switch in settings
    document.querySelectorAll('.theme-toggle-switch').forEach(input => {
      input.checked = theme === 'dark';
    });
  }

  // Immediately apply theme before DOM renders (avoids flashing)
  const initialTheme = getTheme();
  applyTheme(initialTheme);

  // Setup DOM listeners once ready
  document.addEventListener('DOMContentLoaded', () => {
    applyTheme(getTheme());

    // Auto-bind any theme toggle button
    document.querySelectorAll('.theme-toggle-btn').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault();
        toggleTheme();
      });
    });

    // Auto-bind settings toggle switch
    document.querySelectorAll('.theme-toggle-switch').forEach(toggleInput => {
      toggleInput.addEventListener('change', (e) => {
        setTheme(e.target.checked ? 'dark' : 'light');
      });
    });
  });

  // Listen for storage changes from other tabs/frames
  window.addEventListener('storage', (e) => {
    if (e.key === THEME_KEY) {
      applyTheme(e.newValue || 'light');
    }
  });

  // Listen for postMessage from parent iframe
  window.addEventListener('message', (e) => {
    if (e.data && e.data.type === 'guidea2z_set_theme') {
      applyTheme(e.data.theme);
    }
  });

  // Expose globally
  window.Guidea2zTheme = {
    get: getTheme,
    set: setTheme,
    toggle: toggleTheme,
    apply: applyTheme
  };
})();

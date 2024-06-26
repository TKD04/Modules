/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./**/*.html", "./src/**/*.{js,jsx,ts,tsx}"],
  plugins: [require("@tailwindcss/typography", require("@tailwindcss/forms"))],
};

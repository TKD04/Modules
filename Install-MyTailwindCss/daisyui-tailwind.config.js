/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{html,tsx}"],
  plugins: [require("@tailwindcss/typography"), require("daisyui")],
};

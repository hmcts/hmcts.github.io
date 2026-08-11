// Entry point for the GOV.UK Frontend bundle that govuk_tech_docs' layout expects.
//
// govuk_tech_docs 6 renders `javascript_include_tag :govuk_frontend, type: "module"`
// in its core layout, and ships the bundle as `govuk_frontend_all.js` on its asset
// path. A consuming site has to provide the named entry point itself - the same
// pattern as application.js requiring govuk_tech_docs.
//
// Without this file every page links a script that was never generated, which
// renders fine and fails the link check.
//= require govuk_frontend_all

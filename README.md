# Review automation
Includes Schematron rules and customized terminology checker file (for Oxygen XML Author terminology checker plugin) for automated reviews and validation of technical documentation in Oxygen XML Author.

For automated reviews using the Vale linter and lefthook (GitHub hook), see my [vale_linter](https://github.hpe.com/eric-szegedi/vale_linter/wiki) repository.

<b>When to use which review automation tool?</b>
1. What is purpose of review?
   
   Style Guide - Vale, terminology checker plugin, Schematron (limited style checking)
   
   Grammar - Schematron, Vale, terminology checker plugin
   
   **Note** Schematron can be used for implementing style guides and grammar, but if you have too many rules it becomes unusable.

2. What tool(s) can the review automation tool be integrated with?

   Oxygen Author XML - Schematron, terminology checker plugin, limited Vale styles via the terminology checker plugin
   
   VS Code - Vale
   
   Git / GitHub - Vale through either [GitHub Actions](https://github.com/errata-ai/vale-action). (It has to be enabled by writing this email address - scm_ghe_admins@groups.ext.hpe.com - to ask the admins to enable it for your repo) or [Git hooks](https://github.hpe.com/eric-szegedi/vale_linter/wiki/Automating-Vale-linter-checks-with-lefthook)

<b>For more details, see [review automation wiki](https://github.hpe.com/eric-szegedi/review_automation/wiki)</b>
  
   * [Using Schematron in Oxygen Author](https://github.hpe.com/eric-szegedi/review_automation/wiki/Using-Schematron-in-Oxygen-XML-Author)
   * [Using Terminology Checker in Oxygen Author](https://github.hpe.com/eric-szegedi/review_automation/wiki/Using-Terminology-Checker-in-Oxygen-XML-Author)

<b>How to contribute:</b>

1. [Report issues and request enhancements](https://github.hpe.com/eric-szegedi/review_automation/issues)

2. Contribute to the repository, using the [Git forking workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow).


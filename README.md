# Review automation
Includes Schematron rules and customized terminology checker file (for Oxygen Author XML terminology checker plugin) for automated reviews of tech documentation in Oxygen Author XML .

For automated reviews using the Vale linter and lefthook (GitHub hook), see my [vale_linter](https://github.hpe.com/eric-szegedi/vale_linter/wiki) repository.

<b>When to use which review automation tool?</b>
1. What is purpose of review?

   Structure - Schematron and terminology checker plugin
   
   Style - Vale, terminology checker plugin
   
   Grammar - Vale, terminology checker plugin
   
   **Note** Schematron can be used for implementing style guides and grammar, but if you have too many rules it becomes unusable.

2. What tool(s) will the review automation tool be integrated with?

   Oxygen Author XML - Schematron, terminology checker plugin, limited Vale styles via the terminology checker plugin
   
   VS Code - Vale
   
   Git / GitHub - Vale through either GitHub actions or Git hooks

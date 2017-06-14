# puppet-module-chattr
===

Hack to get around Puppet's inability to manage files with the immutable attribute set as described in issue [PUP-1199](https://tickets.puppetlabs.com/browse/PUP-1199)

===

# Compatibility
---------------
This module is built for use with Puppet v4 with Ruby versions 1.8.7, 1.9.3, and 2.0.0 on all Linux systems.

===

# Requirements
---------------
The chattr module requires the [puppetlabs-stdlib](https://github.com/puppetlabs/puppetlabs-stdlib) module.

===

# Usage

If `/etc/no_change` is immutable and meant to stay that way, this would remove the immutable attribute allowing you to modify it with a file resource in another class and then add the immutable attribute back.

<pre>
chattr::attribute_adds:
  '/etc/no_change':
    attribute: 'i'
chattr::attribute_removes:
  '/etc/no_change immutable':
    file_path: '/etc/no_change'
    attribute: 'i'
</pre>

In order to update multiple attributes on a single file use distinct names along with the file_path parameter.

===

# Ordering

exec to remove attributes -> all other `file`, `host`, and `resources` types -> exec to add attributes

===

# Class chattr
## Parameters
------------

attribute_adds
--------------
Hash of chattr::attribute_add defines.

- *Default*: undef

attribute_adds_hiera_merge
--------------------------
Boolean to control merges of all found instances of chattr::attribute_adds Hiera. This is useful for specifying resources at different levels of the hierarchy and having them all included in the catalog.

- *Default*: true

attribute_removes
-----------------
Hash of chattr::attribute_remove defines.

- *Default*: undef

attribute_removes_hiera_merge
-----------------------------
Boolean to control merges of all found instances of chattr::attribute_removes Hiera. This is useful for specifying resources at different levels of the hierarchy and having them all included in the catalog.

- *Default*: true

# Define chattr::attribute_add
## Parameters
------------

attribute
---------
chattr attribute to add. See CHATTR(1). Defaults to 'i' for immutable.

- *Default*: 'i'

file_path
---------
Fully qualified path to the file to be modified.

- *Default*: undef

# Define chattr::attribute_remove
## Parameters
------------

attribute
---------
chattr attribute to remove. See CHATTR(1). Defaults to 'i' for immutable.

- *Default*: 'i'

file_path
---------
Fully qualified path to the file to be modified.

- *Default*: undef

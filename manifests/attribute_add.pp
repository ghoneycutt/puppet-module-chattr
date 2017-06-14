# == Define: chattr::attribute_add
#
define chattr::attribute_add (
  Pattern[/^[aAcCdDeijsStTu]{1}$/] $attribute = 'i',
  Optional[String] $file_path = undef,
) {

  File <||> -> Exec <| tag == 'chattr_attribute_add' |>
  Host <||> -> Exec <| tag == 'chattr_attribute_add' |>
  Resources <||> -> Exec <| tag == 'chattr_attribute_add' |>

  case $file_path {
    undef:           { $t_file_path = $name }
    default:         { $t_file_path = $file_path }
  }

  exec { "chattr +${attribute} ${t_file_path}":
    path   => ['/usr/sbin','/usr/bin','/bin'],
    unless => "lsattr ${t_file_path} | awk \'{print \$1}\' |grep ${attribute}",
    tag    => 'chattr_attribute_add',
  }
}

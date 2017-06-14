# == Define: chattr::attribute_remove
#
define chattr::attribute_remove (
  Pattern[/^[aAcCdDeijsStTu]{1}$/] $attribute = 'i',
  Optional[String] $file_path = undef,
) {

  Exec <| tag == 'chattr_attribute_remove' |> -> File <||>
  Exec <| tag == 'chattr_attribute_remove' |> -> Host <||>
  Exec <| tag == 'chattr_attribute_remove' |> -> Resources <||>

  case $file_path {
    undef:           { $t_file_path = $name }
    default:         { $t_file_path = $file_path }
  }

  exec { "chattr -${attribute} ${t_file_path}":
    path   => ['/usr/sbin','/usr/bin','/bin'],
    onlyif => "lsattr ${t_file_path} | awk \'{print \$1}\' |grep ${attribute}",
    tag    => 'chattr_attribute_remove',
  }
}

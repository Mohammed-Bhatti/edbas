require 'open3'

Facter.add('checkfs') do
  setcode do
    value = nil
    #stderr, status = Open3.capture2e("ls /var/data/edb/as9.6/data2")
    stderr, status = Open3.capture2e("ls /var/data/edb/as9.6/data")
    str = status.to_s
    if !(str =~ /exit 0/)
      value = -1
    else
      value = 1
    end
  end
end

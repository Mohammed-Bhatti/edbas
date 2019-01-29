Facter.add(:edbasenv) do
  setcode do
    fqdn = Facter.value(:fqdn)
    case fqdn
      #when /^.*\.ndev\.coic\.mil/
      when /^.*\.catapult\.ndev\.jido\.mil/
        edbasenv = 'ndev'
      when /^.*\.ncr\.atac\.smil\.mil/
        edbasenv = 'slan'
      when /^.*\.ncr\.atac\.ic\.gov/
        edbasenv = 'tlan'
      when /^.*\.usa\.bices\.org/
        edbasenv = 'bices'
      else
        edbasenv = 'unk'
    end
    edbasenv
  end
end

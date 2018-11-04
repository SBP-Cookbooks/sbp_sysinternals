# Inspec test for recipe sbp_baseline::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

if os[:family] == 'windows'
  # write your windows test here
  describe file('C:/SysinternalsSuite') do
    it { should exist }
    it { should be_directory }
  end
end

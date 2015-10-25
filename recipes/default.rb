include_recipe 'apt'
include_recipe 'git'
include_recipe 'java'


# Clone kahvihub
# execute 'clone kahvihub' do
# 	command "git clone https://github.com/uh-cs-iotlab/kahvihub.git"
# end

# Copy the install script
# cookbook_file "#{node['iothub']['bin_dir']}/kahvihub-install.sh" do
# 	source 'kahvihub-install.sh'
# end


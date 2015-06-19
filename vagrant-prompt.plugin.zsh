# vim:ft=zsh ts=2 sw=2 sts=2
#
function vagrant_prompt_info() {
  test -d .vagrant && test -f Vagrantfile
  if [[ "$?" == "0" ]]; then
    statuses=$(vagrant status 2> /dev/null | grep -P -x "\w+\s+[\w\s]+\s\(\w+\)")
    statuses=("${(f)statuses}")
    printf '%s' $ZSH_THEME_VAGRANT_PROMPT_PREFIX
    for vm_details in $statuses; do
      # vm_state=$(echo $vm_details | awk '{print $2}' 2>/dev/null)
      vm_state=$(echo $vm_details | grep -o -E "saved|poweoff|not created|running")
      if [[ "$vm_state" == "running" ]]; then
        printf '%s' $ZSH_THEME_VAGRANT_PROMPT_RUNNING
      elif [[ "$vm_state" == "saved" ]]; then
        printf '%s' $ZSH_THEME_VAGRANT_PROMPT_SUSPENDED
      elif [[ "$vm_state" == "not created" ]]; then
        printf '%s' $ZSH_THEME_VAGRANT_PROMPT_NOT_CREATED
      elif [[ "$vm_state" == "poweroff" ]]; then
        printf '%s' $ZSH_THEME_VAGRANT_PROMPT_POWEROFF
      fi
    done
    printf '%s' $ZSH_THEME_VAGRANT_PROMPT_SUFFIX
  fi
}

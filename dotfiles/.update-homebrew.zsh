#!/bin/zsh
brew_current_time=$(date +"%Y%m%d %H%M%S")
brew_update_version=$(date +"%Y%m%d")
brew_update_version_file="$HOME/.homebrew-lastupdate"
brew_update_in_progress_file="$HOME/.homebrew-update-in-progress"
brew_log="$HOME/.homebrew-update-log"

brew_upgrade_required=0
test -f "$brew_update_version_file" || brew_upgrade_required=1

if [[ $brew_upgrade_required -eq 0 ]]; then
    this_brew_version=$(cat "$brew_update_version_file")
    test "$this_brew_version" = "$brew_update_version" || brew_upgrade_required=1
fi

if [ -f "$brew_update_in_progress_file" ]; then
    update_progress_brew_version=$(cat "$brew_update_in_progress_file")

	if [ "$update_progress_brew_version" = "$brew_update_version" ]; then
            echo "[Homebrew] Homebrew updater locked, preventing update @ $brew_current_time" >> $brew_log
	    echo "[Homebrew] Another instance of homebrew updater is running homebrew updates, Skipping."
	    brew_upgrade_required=0
	else
            echo "[Homebrew] Homebrew updater locked, seems to be orphaned @ $brew_current_time" >> $brew_log
	    echo -n "[Homebrew] Homebrew auto-updater found a lock file, but it seems to be orphaned. Delete the lock file? [Y/n] "
        read -r -k 1 option
        [[ "$option" != $'\n' ]] && echo
        case "$option" in
            [yY$'\n']) rm $brew_update_in_prgress_file ;;
            [nN]) echo "[Homebrew] Preserving lock file..." ;;
        esac
	fi
fi

if [[ $brew_upgrade_required -eq 1 ]]; then
    echo "[Homebrew] Asked user to update @ $brew_current_time" >> $brew_log

    echo -n "[Homebrew] Would you like to update? [Y/n] "
    read -r -k 1 option
    [[ "$option" != $'\n' ]] && echo
    case "$option" in
      [yY$'\n']) brew_upgrade_required=1 ;;
      [nN]) brew_upgrade_required=0 ;;
    esac

    if [[ $brew_upgrade_required -eq 0 ]]; then
        echo "[Homebrew] User declined update @ $brew_current_time" >> $brew_log

	echo -n "[Homebrew] Do you want to skip update today? [y/N] "
        read -r -k 1 option
        [[ "$option" != $'\n' ]] && echo
        case "$option" in
            [nN$'\n']) brew_skip_update=0 ;;
            [yY]) brew_skip_update=1 ;;
        esac
    fi

    if [[ $brew_skip_update -eq 1 ]]; then
        echo "[Homebrew] Ignore update today @ $brew_current_time" >> $brew_log

	echo -n "[Homebrew] All right! I will not ask you to update for today."
	echo -n $brew_update_version > $brew_update_version_file
    fi
fi

if [[ $brew_upgrade_required -eq 1 ]]; then
    echo "[Homebrew] Updating Homebrew..."
    echo -n $brew_update_version > $brew_update_in_progress_file
    echo "[Homebrew] Update Triggered @ $brew_current_time" >> $brew_log
    brew update
    brew upgrade
    brew cleanup
    brew doctor
    echo "[Homebrew] Update Completed @ $brew_current_time" >> $brew_log
    echo -n $brew_update_version > $brew_update_version_file
    rm -f $brew_update_in_progress_file
    echo
else
    echo
fi

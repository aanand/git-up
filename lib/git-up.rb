require 'colored'
require 'grit'

class GitUp
  def initialize(args)
    @repo   = Grit::Repo.new(args.first || File.expand_path("."))
    @head   = @repo.head
  end

  def run
    @repo.git.fetch

    with_stash do
      returning_to_current_branch do
        @repo.branches.each do |branch|
          next unless remote = remote_for_branch(branch)

          print branch.name.ljust(20)

          if remote.commit.sha == branch.commit.sha
            puts "up to date".green
            next
          end

          merge_base = @repo.git.send("merge-base", {}, branch.name, remote.name).strip

          if merge_base == remote.commit.sha
            puts "ahead of upstream".green
            next
          end

          if merge_base == branch.commit.sha
            puts "fast-forwarding...".yellow
          else
            puts "rebasing...".yellow
          end

          @repo.git.checkout({}, branch.name)
          @repo.git.rebase({}, remote.name)
        end
      end
    end
  end

  def remote_for_branch(branch)
    if remote_name = @repo.config["branch.#{branch.name}.remote"]
      @repo.remotes.find { |r| r.name == "#{remote_name}/#{branch.name}" }
    else
      nil
    end
  end

  def with_stash
    stashed = false

    status = @repo.status
    change_count = status.added.length + status.changed.length + status.deleted.length

    if change_count > 0
      puts "stashing #{change_count} changes".magenta
      @repo.git.stash
      stashed = true
    end

    begin
      yield
    ensure
      if stashed
        puts "unstashing".magenta
        @repo.git.stash({}, "apply")
      end
    end
  end

  def returning_to_current_branch
    unless @repo.head.respond_to?(:name)
      puts "You're not currently on a branch. I'm exiting in case you're in the middle of something.".red
      return
    end

    branch_name = @repo.head.name

    begin
      yield
    ensure
      unless @repo.head.respond_to?(:name) and @repo.head.name == branch_name
        puts "returning to #{branch_name}".magenta
        @repo.git.checkout({}, branch_name)
      end
    end
  end
end


require 'fileutils'

module Elm
  class IO
    class << self
      def with_project_copy(*elm_files, &block)
        raise NameCollisionError unless file_names_uniq?(elm_files)

        src_dirs = elm_files.map { |file| File.dirname(file) }.uniq

        Dir.mktmpdir do |tmp_dir|
          src_dirs.each do |src_dir|
            FileUtils.cp_r(File.join(src_dir, '.'), tmp_dir)
          end

          tmp_files = elm_files.map { |file| File.basename(file) }
          Dir.chdir(tmp_dir) do
            block.call(*tmp_files)
          end
        end
      end

      def file_names_uniq?(files)
        file_names = files.map { |file| File.basename(file) }
        file_names == file_names.uniq
      end
    end
  end
end

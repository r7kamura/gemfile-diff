# frozen_string_literal: true

require 'bundler'
require 'diffy'
require 'yaml'

module GemfileDiff
  # Return pairs of gem name and its version as a Hash.
  class GemfileLockParser
    class << self
      # @param [String]
      # @return [Hash]
      def call(path:)
        new(path:).call
      end
    end

    def initialize(path:)
      @path = path
    end

    def call
      specs.each_with_object({}) do |specification, hash|
        hash[specification.name] = specification.version.to_s
      end
    end

    private

    def bundler_lockfile_parser
      ::Bundler::LockfileParser.new(content)
    end

    def content
      ::File.read(@path)
    end

    def specs
      bundler_lockfile_parser.specs
    end
  end

  # Return a Hash from user-input.
  class InputParser
    class << self
      # @param [Array<String>] argv
      # @return [Hash]
      def call(argv: ::ARGV)
        new(argv:).call
      end
    end

    def initialize(argv:)
      @argv = argv
    end

    def call
      {
        gemfile_lock_a:,
        gemfile_lock_b:,
        ignored_gem_names:
      }
    end

    private

    def gemfile_lock_a
      @argv[0]
    end

    def gemfile_lock_b
      @argv[1]
    end

    def ignore
      @argv[2] || ''
    end

    def ignored_gem_names
      ignore.split
    end
  end

  # Return ANSI-colored pretty diff from 2 objects.
  class PrettyDiffGenerator
    class << self
      # @param [Object] a
      # @param [Object] b
      # @return [String]
      def call(a:, b:)
        new(a:, b:).call
      end
    end

    def initialize(a:, b:)
      @a = a
      @b = b
    end

    def call
      ::Diffy::Diff.new(
        @a.to_yaml,
        @b.to_yaml
      ).to_s(:color)
    end
  end
end

input = GemfileDiff::InputParser.call

a = GemfileDiff::GemfileLockParser.call(path: input[:gemfile_lock_a]).except(*input[:ignored_gem_names])
b = GemfileDiff::GemfileLockParser.call(path: input[:gemfile_lock_b]).except(*input[:ignored_gem_names])

abort GemfileDiff::PrettyDiffGenerator.call(a:, b:) if a != b

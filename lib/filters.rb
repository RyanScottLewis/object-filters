require 'pathname'
require 'bundler/setup'
require 'version'
require 'active_support/concern'
require 'active_support/callbacks'

__PATH__ = Pathname.new(__FILE__)
$:.unshift(__PATH__.dirname.to_s) unless $:.include?(__PATH__.dirname.to_s)

module Filters
  extend ActiveSupport::Concern

  # Uses ActiveSupport::Callbacks as the base functionality. For
  # more details on the whole callback system, read the documentation
  # for ActiveSupport::Callbacks.
  include ActiveSupport::Callbacks

  included do
    define_callbacks :process_action, :terminator => "response_body", :skip_after_callbacks_if_terminated => true
  end

  # Override AbstractController::Base's process_action to run the
  # process_action callbacks around the normal behavior.
  def process_action(*args)
    run_callbacks(:process_action) do
      super
    end
  end

  module ClassMethods
    # If :only or :except are used, convert the options into the
    # :unless and :if options of ActiveSupport::Callbacks.
    # The basic idea is that :only => :index gets converted to
    # :if => proc {|c| c.action_name == "index" }.
    #
    # ==== Options
    # * <tt>only</tt>   - The callback should be run only for this action
    # * <tt>except</tt>  - The callback should be run for all actions except this action
    def _normalize_callback_options(options)
      if only = options[:only]
        only = Array(only).map {|o| "action_name == '#{o}'"}.join(" || ")
        options[:if] = Array(options[:if]) << only
      end
      if except = options[:except]
        except = Array(except).map {|e| "action_name == '#{e}'"}.join(" || ")
        options[:unless] = Array(options[:unless]) << except
      end
    end

    # Skip before, after, and around filters matching any of the names
    #
    # ==== Parameters
    # * <tt>names</tt> - A list of valid names that could be used for
    #   callbacks. Note that skipping uses Ruby equality, so it's
    #   impossible to skip a callback defined using an anonymous proc
    #   using #skip_filter
    def skip_filter(*names)
      skip_before_filter(*names)
      skip_after_filter(*names)
      skip_around_filter(*names)
    end

    # Take callback names and an optional callback proc, normalize them,
    # then call the block with each callback. This allows us to abstract
    # the normalization across several methods that use it.
    #
    # ==== Parameters
    # * <tt>callbacks</tt> - An array of callbacks, with an optional
    #   options hash as the last parameter.
    # * <tt>block</tt>    - A proc that should be added to the callbacks.
    #
    # ==== Block Parameters
    # * <tt>name</tt>     - The callback to be added
    # * <tt>options</tt>  - A hash of options to be used when adding the callback
    def _insert_callbacks(callbacks, block = nil)
      options = callbacks.last.is_a?(Hash) ? callbacks.pop : {}
      _normalize_callback_options(options)
      callbacks.push(block) if block
      callbacks.each do |callback|
        yield callback, options
      end
    end

    ##
    # :method: before_filter
    #
    # :call-seq: before_filter(names, block)
    #
    # Append a before filter. See _insert_callbacks for parameter details.

    ##
    # :method: prepend_before_filter
    #
    # :call-seq: prepend_before_filter(names, block)
    #
    # Prepend a before filter. See _insert_callbacks for parameter details.

    ##
    # :method: skip_before_filter
    #
    # :call-seq: skip_before_filter(names)
    #
    # Skip a before filter. See _insert_callbacks for parameter details.

    ##
    # :method: append_before_filter
    #
    # :call-seq: append_before_filter(names, block)
    #
    # Append a before filter. See _insert_callbacks for parameter details.

    ##
    # :method: after_filter
    #
    # :call-seq: after_filter(names, block)
    #
    # Append an after filter. See _insert_callbacks for parameter details.

    ##
    # :method: prepend_after_filter
    #
    # :call-seq: prepend_after_filter(names, block)
    #
    # Prepend an after filter. See _insert_callbacks for parameter details.

    ##
    # :method: skip_after_filter
    #
    # :call-seq: skip_after_filter(names)
    #
    # Skip an after filter. See _insert_callbacks for parameter details.

    ##
    # :method: append_after_filter
    #
    # :call-seq: append_after_filter(names, block)
    #
    # Append an after filter. See _insert_callbacks for parameter details.

    ##
    # :method: around_filter
    #
    # :call-seq: around_filter(names, block)
    #
    # Append an around filter. See _insert_callbacks for parameter details.

    ##
    # :method: prepend_around_filter
    #
    # :call-seq: prepend_around_filter(names, block)
    #
    # Prepend an around filter. See _insert_callbacks for parameter details.

    ##
    # :method: skip_around_filter
    #
    # :call-seq: skip_around_filter(names)
    #
    # Skip an around filter. See _insert_callbacks for parameter details.

    ##
    # :method: append_around_filter
    #
    # :call-seq: append_around_filter(names, block)
    #
    # Append an around filter. See _insert_callbacks for parameter details.

    # set up before_filter, prepend_before_filter, skip_before_filter, etc.
    # for each of before, after, and around.
    [:before, :after, :around].each do |filter|
      class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
        # Append a before, after or around filter. See _insert_callbacks
        # for details on the allowed parameters.
        def #{filter}_filter(*names, &blk)                                                    # def before_filter(*names, &blk)
          _insert_callbacks(names, blk) do |name, options|                                    #   _insert_callbacks(names, blk) do |name, options|
            set_callback(:process_action, :#{filter}, name, options)                          #     set_callback(:process_action, :before, name, options)
          end                                                                                 #   end
        end                                                                                   # end

        # Prepend a before, after or around filter. See _insert_callbacks
        # for details on the allowed parameters.
        def prepend_#{filter}_filter(*names, &blk)                                            # def prepend_before_filter(*names, &blk)
          _insert_callbacks(names, blk) do |name, options|                                    #   _insert_callbacks(names, blk) do |name, options|
            set_callback(:process_action, :#{filter}, name, options.merge(:prepend => true))  #     set_callback(:process_action, :before, name, options.merge(:prepend => true))
          end                                                                                 #   end
        end                                                                                   # end

        # Skip a before, after or around filter. See _insert_callbacks
        # for details on the allowed parameters.
        def skip_#{filter}_filter(*names)                                                     # def skip_before_filter(*names)
          _insert_callbacks(names) do |name, options|                                         #   _insert_callbacks(names) do |name, options|
            skip_callback(:process_action, :#{filter}, name, options)                         #     skip_callback(:process_action, :before, name, options)
          end                                                                                 #   end
        end                                                                                   # end

        # *_filter is the same as append_*_filter
        alias_method :append_#{filter}_filter, :#{filter}_filter  # alias_method :append_before_filter, :before_filter
      RUBY_EVAL
    end
  end
end
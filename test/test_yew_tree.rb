require 'test/unit'

require 'lib/yew'

class TestYew < Test::Unit::TestCase

  def setup
    @hash = {
      :orientdb => {
        :user => 'root',
        :pass => 'let-me-in'
      },
      'testing' => {
        'frameworks' => {
          'rspec' => false,
          'minitest' => true
        }
      }
    }

    @tree = Yew::Tree.new(@hash)
  end

  def test_lookups_for_symbol_keys
    user = @tree.orientdb.user

    assert_equal('root', user)
  end

  def test_lookups_for_string_keys
    minitest = @tree.testing.frameworks.minitest
    rspec = @tree.testing.frameworks.rspec

    assert minitest
    refute rspec
  end

  def test_obtains_underlying_hash
    testing_hash = @tree.testing[]

    assert_equal(@hash['testing'], testing_hash)
  end

  def test_subtree_can_be_traversed_as_usual
    subtree = @tree.orientdb

    assert_equal('root', subtree.user)
  end

  def test_lookups_using_hash_semantics
    user = @tree[:orientdb][:user]

    assert_equal('root', user)
  end

  def test_subtree_can_be_obtained_using_hash_semantics
    subtree = @tree[:orientdb]

    assert_equal('root', subtree.user)
  end

  def test_raises_an_error_when_accessing_non_existing_paths
    assert_raises(RuntimeError) {
      @tree.orientdb.timeout
    }
  end

  def test_raises_errors_having_meaningful_messages
    e = nil

    begin
      @tree.orientdb.timeout
    rescue RuntimeError => e; end

    assert_match(/timeout not found at \/orientdb/, e.message)
  end
end

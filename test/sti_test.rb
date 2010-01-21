require File.dirname(__FILE__) + '/test_helper'

class STIModelTest < Test::Unit::TestCase

  context "A slugged model using single table inheritance" do

    setup do
      @novel = Novel.new :name => "Test novel"
      @novel.save!
    end

    teardown do
      Novel.delete_all
      $slug_class.delete_all
    end

    should "have a slug" do
      assert_not_nil @novel.slug
    end

    context "found by its friendly id" do

      setup do
        @novel = Novel.find(@novel.friendly_id)
      end

      should "not indicate that it has a better id" do
        assert @novel.friendly_id_status.best?
      end

    end


    context "found by its numeric id" do

      setup do
        @novel = Novel.find(@novel.id)
      end

      should "indicate that it has a better id" do
        assert !@novel.friendly_id_status.best?
      end

    end

  end

end
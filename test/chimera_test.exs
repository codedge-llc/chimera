defmodule ChimeraTest do
  use ExUnit.Case
  doctest Chimera

  alias Chimera.{That, This}

  test "converts This to That" do
    this = %This{}
    that = That.new(this)

    assert that.a == 1234
    assert that.b == false
    assert that.c == "yes"
    assert that.d == :error
  end

  test "converts That to This" do
    that = %That{}
    this = This.new(that)

    assert this.a == 4567
    assert this.b == true
    assert this.c == "no"
  end

  describe ":map option" do
    test "sets raw value for key" do
      this = %This{}
      that = That.new(this, map: [a: -7])

      assert that.a == -7
    end

    test "executes function for given key" do
      this = %This{}

      that =
        That.new(this,
          map: [
            a: fn this -> this.a * 3 end
          ]
        )

      assert that.a == 1234 * 3
    end
  end
end

describe 'sample',->

  describe 'aaa', ->

    before ->
      1

    it "sample it", ->
      1.should.be.eql 1

    it 'failed it', ->
      1.should.be.eql 2

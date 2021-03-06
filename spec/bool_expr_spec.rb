module Z3
  describe BoolExpr do
    let(:a) { Z3.Bool("a") }
    let(:b) { Z3.Bool("b") }
    let(:c) { Z3.Bool("c") }
    let(:x) { Z3.Int("x") }

    it "&" do
      expect([a ==  true, b ==  true, c == (a & b)]).to have_solution(c =>  true)
      expect([a ==  true, b == false, c == (a & b)]).to have_solution(c => false)
      expect([a == false, b ==  true, c == (a & b)]).to have_solution(c => false)
      expect([a == false, b == false, c == (a & b)]).to have_solution(c => false)
    end

    it "|" do
      expect([a ==  true, b ==  true, c == (a | b)]).to have_solution(c =>  true)
      expect([a ==  true, b == false, c == (a | b)]).to have_solution(c =>  true)
      expect([a == false, b ==  true, c == (a | b)]).to have_solution(c =>  true)
      expect([a == false, b == false, c == (a | b)]).to have_solution(c => false)
    end

    it "^" do
      expect([a ==  true, b ==  true, c == (a ^ b)]).to have_solution(c => false)
      expect([a ==  true, b == false, c == (a ^ b)]).to have_solution(c =>  true)
      expect([a == false, b ==  true, c == (a ^ b)]).to have_solution(c =>  true)
      expect([a == false, b == false, c == (a ^ b)]).to have_solution(c => false)
    end

    it "!=" do
      expect([a ==  true, b ==  true, c == (a != b)]).to have_solution(c => false)
      expect([a ==  true, b == false, c == (a != b)]).to have_solution(c =>  true)
      expect([a == false, b ==  true, c == (a != b)]).to have_solution(c =>  true)
      expect([a == false, b == false, c == (a != b)]).to have_solution(c => false)
    end

    it "implies" do
      expect([a ==  true, b ==  true, c == a.implies(b)]).to have_solution(c =>  true)
      expect([a ==  true, b == false, c == a.implies(b)]).to have_solution(c => false)
      expect([a == false, b ==  true, c == a.implies(b)]).to have_solution(c =>  true)
      expect([a == false, b == false, c == a.implies(b)]).to have_solution(c =>  true)
    end

    it "iff" do
      expect([a ==  true, b ==  true, c == a.iff(b)]).to have_solution(c =>  true)
      expect([a ==  true, b == false, c == a.iff(b)]).to have_solution(c => false)
      expect([a == false, b ==  true, c == a.iff(b)]).to have_solution(c => false)
      expect([a == false, b == false, c == a.iff(b)]).to have_solution(c =>  true)
    end

    it "==" do
      expect([a ==  true, b ==  true, c == (a == b)]).to have_solution(c =>  true)
      expect([a ==  true, b == false, c == (a == b)]).to have_solution(c => false)
      expect([a == false, b ==  true, c == (a == b)]).to have_solution(c => false)
      expect([a == false, b == false, c == (a == b)]).to have_solution(c =>  true)
    end

    it "~ and !" do
      expect([a ==  true, b == ~a]).to have_solution(b => false)
      expect([a == false, b == ~a]).to have_solution(b =>  true)
      expect([a ==  true, b == !a]).to have_solution(b => false)
      expect([a == false, b == !a]).to have_solution(b =>  true)
    end

    it "if then else" do
      expect([a ==  true, x == a.ite(2, 3)]).to have_solution(x => 2)
      expect([a == false, x == a.ite(2, 3)]).to have_solution(x => 3)
    end

    it "to_b" do
      expect{Z3.Bool("a").to_b}.to raise_error(Z3::Exception)
      expect(Z3.Const(true).to_b).to eq(true)
      expect(Z3.Const(false).to_b).to eq(false)
      expect((Z3.Const(true) & Z3.Const(false)).to_b).to eq(false)
    end
  end
end

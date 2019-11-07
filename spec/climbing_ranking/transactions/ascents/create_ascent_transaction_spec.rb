RSpec.describe Ascents::CreateAscentTransaction do
  let(:transaction_call) { transaction.call(line_params) }
  let(:transaction) do
    described_class
      .new
      .with_step_args(
        calculate_ascent_points: [ascent: ascent_params],
        create_ascent: [user: user]
      )
  end
  let(:ascent_repo) { AscentRepository.new }
  let(:line_repo) { LineRepository.new }
  let(:user) { create(:user) }
  let(:ascent_params) { { date: Date.new(2019, 10, 10), style: 'os' } }

  context 'when everything goes well' do
    let(:line_params) { attributes_for(:line) }

    context 'when line exists' do
      let!(:line) { create(:line, line_params) }

      it 'returns success' do
        expect(transaction_call.success?).to eq(true)
      end

      it "doesn't create new line" do
        expect { transaction_call }.to change(line_repo.lines, :count).by(0)
      end

      it 'creates ascent' do
        expect { transaction_call }.to change(ascent_repo.ascents, :count).by(1)
      end

      it 'caretes ascent with proper attributes', :aggregate_failrues do
        success = transaction_call.success
        expect(success.user_id).to eq(user.id)
        expect(success.line_id).to eq(line.id)
        expect(success.style).to eq(ascent_params[:style])
        expect(success.date.to_date).to eq(ascent_params[:date])
        expect(success.points).to eq(425)
      end
    end

    context 'when line not exists' do
      it 'creates new line' do
        expect { transaction_call }.to change(line_repo.lines, :count).by(1)
      end

      it 'creates line with proper attributes' do
        transaction_call
        expect(line_repo.last).to include(line_params)
      end
    end
  end

  context 'when line attributes are ivlaid' do
    let(:line_params) { { invalid: 'invalid' } }

    it 'fails on find_or_create_line and raises Hanami::Model::UnknownAttributeError' do
      expect(transaction).to fail_on(:find_or_create_line)
        .with(line_params).and_raise(Hanami::Model::UnknownAttributeError)
    end
  end

  context 'when line attributes are missing' do
    let(:line_params) { {} }

    it 'fails on find_or_create_line and raises Hanami::Model::NotNullConstraintViolationError' do
      expect(transaction).to fail_on(:find_or_create_line)
        .with(line_params).and_raise(Hanami::Model::NotNullConstraintViolationError)
    end
  end

  context 'when ascent attributes are missing' do
    let(:line_params) { attributes_for(:line) }

    context 'when style is missing' do
      let(:ascent_params) { {} }

      it 'fails on calculate_ascent_points step and raises KeyError' do
        expect(transaction).to fail_on(:calculate_ascent_points)
          .with(line_params).and_raise(KeyError)
      end
    end

    context 'when date is missing' do
      let(:ascent_params) { { style: 'rp' } }

      it 'fails on create_ascent step and raises Hanami::Model::NotNullConstraintViolationError' do
        expect(transaction).to fail_on(:create_ascent)
          .with(line_params).and_raise(Hanami::Model::NotNullConstraintViolationError)
      end
    end
  end
end

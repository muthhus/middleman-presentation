# encoding: utf-8
require 'spec_helper'

RSpec.describe FrontendComponent do
  context '#initialize' do
    it 'requires a resource locator' do
      expect {
        FrontendComponent.new(resource_locator: 'latest')
      }.not_to raise_error
    end

    it 'supports a full url as resource locator' do
      expect {
        FrontendComponent.new(resource_locator: 'http://www.example.org/test')
      }.not_to raise_error
    end

    it 'fails if neither github nor resource_locator is given' do
      expect {
        FrontendComponent.new
      }.to raise_error ArgumentError
    end

    it 'build github url' do
      expect {
        FrontendComponent.new(github: 'example/example')
      }.not_to raise_error
    end

    it 'fails if name is empty when extracted from url' do
      expect {
        FrontendComponent.new(resource_locator: 'http://www.example.org')
      }.to raise_error ArgumentError
    end
  end

  context '#name' do
    it 'extracts name from url' do
      component = FrontendComponent.new(resource_locator: 'http://example.org/test')
      expect(component.name).to eq 'test'
    end

    it 'uses name' do
      component = FrontendComponent.new(resource_locator: 'http://example.org/test', name: 'name')
      expect(component.name).to eq 'name'
    end
  end

  context '.parse' do
    let(:hashes) do 
      [
        {
          name: 'name',
          resource_locator: 'https://example.org/test',
          javascripts: [
            'path/to/file.js',
          ],
          stylesheets: [
            'path/to/file.scss',
          ],
        }
      ]
    end

    it 'reads data from array of hashes' do
      component = FrontendComponent.parse(hashes)
      expect(component.name).to eq 'name'
      expect(component.resource_locator).to eq 'https://example.org/test'
      expect(component.javascripts.first).to eq 'path/to/file.js'
      expect(component.stylesheets.first).to eq 'path/to/file.scss'
    end

    it 'reads data from hash' do
      component = FrontendComponent.parse(hashes.first)
      expect(component.name).to eq 'name'
      expect(component.resource_locator).to eq 'https://example.org/test'
      expect(component.javascripts.first).to eq 'path/to/file.js'
      expect(component.stylesheets.first).to eq 'path/to/file.scss'
    end
  end
end

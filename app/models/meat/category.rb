module Meat
  class Category  < ApplicationRecord
    # has_ltree_hierarchy

    has_one_attached :image

    is_positionable #scope: :parent

    multilang :title
    belongs_to :parent, class_name: "Meat::Category", foreign_key: :parent_id, optional: true
    has_many :children, class_name: "Meat::Category", foreign_key: :parent_id, dependent: :delete_all
    has_many :offers, class_name: "Meat::Offer", foreign_key: :category_id, dependent: :delete_all
    has_many :requests, class_name: "Meat::Category", foreign_key: :category_id, dependent: :delete_all
    has_many :alerts, class_name: "::Meat::Alert", foreign_key: :category_id, dependent: :delete_all

    delegate :title, to: :parent, prefix: true, allow_nil: true

    scope :active_for_offers, ->(){where(active_for_offers: true)}
    scope :active_for_requests, ->(){where(active_for_requests: true)}
    scope :active, ->(){where(active: true)}
    def self.parents
      where(parent_id:[nil,0])
    end

    def as_hash(child_method=:all)
      {
        icon: self.icon.to_s,
        id: self.id,
        parent_id: self.parent_id.to_i,
        title: self.title.to_s,
        cls: self.cls.to_s,
        seo: self.seo_name.to_s,
        markets: [self.market],
        children: self.children.order("title->'#{I18n.locale}' ASC").send(child_method).map{|d| d.as_hash(child_method)}
      }
    end

    def self_and_descendants_ids
      [self.id].concat( self.children.map(&:self_and_descendants_ids) ).flatten.uniq
    end

    def self_and_ancestors_ids
      [self.id].concat( self.parent ? self.parent.self_and_ancestors_ids : [] ).flatten.uniq
    end

  end
end




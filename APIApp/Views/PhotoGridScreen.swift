// ASCollectionView. Created by Apptek Studios 2019

import ASCollectionView
import SwiftUI
import UIKit
import Combine
import URLImage


struct PhotoGridScreen: View
{
    var startingAtBottom: Bool = false
    
    @ObservedObject var stockListViewModel: StockListViewModel
    
    @State var selectedItems: IndexSet = []
        
    typealias SectionID = Int
    
    var section: ASCollectionViewSection<SectionID>
    {
        ASCollectionViewSection(
            id: 0,
            data: self.stockListViewModel.news
            )
        { item, state in
            ZStack(alignment: .bottomTrailing)
            {
                GeometryReader{ geom in
                    
                        NavigationLink(destination: LazyView(NewsItemView(model: WebViewModel(link: item.webUrl ?? ""), item: item))) {
                            URLImage(URL(string: item.urlToImage ?? defaluImageURl)!, placeholder: Image("defaultNewsImage")) { proxy in
                                proxy.image
                                    .resizable()                     // Make image resizable
                                    .aspectRatio(contentMode: .fill) // Fill the frame
                                    .frame(width: geom.size.width, height: geom.size.height)
                                    
                                    .clipped()                     // Clip overlaping parts
                            }
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    var body: some View
    {
        ASCollectionView(
            selectedItems: $selectedItems,
            section: section)
            .layout(self.layout)
            .edgesIgnoringSafeArea(.all)
    }
}

extension PhotoGridScreen
{
    var layout: ASCollectionLayout<Int>
    {
        ASCollectionLayout(scrollDirection: .vertical, interSectionSpacing: 0)
        {
            ASCollectionLayoutSection
                { environment in
                    let isWide = environment.container.effectiveContentSize.width > 500
                    let gridBlockSize = environment.container.effectiveContentSize.width / (isWide ? 5 : 3)
                    let gridItemInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                    let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(gridBlockSize), heightDimension: .absolute(gridBlockSize))
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    item.contentInsets = gridItemInsets
                    let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .absolute(gridBlockSize), heightDimension: .absolute(gridBlockSize * 2))
                    let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitem: item, count: 2)
                    
                    let featureItemSize = NSCollectionLayoutSize(widthDimension: .absolute(gridBlockSize * 2), heightDimension: .absolute(gridBlockSize * 2))
                    let featureItem = NSCollectionLayoutItem(layoutSize: featureItemSize)
                    featureItem.contentInsets = gridItemInsets
                    
                    let fullWidthItemSize = NSCollectionLayoutSize(widthDimension: .absolute(environment.container.effectiveContentSize.width), heightDimension: .absolute(gridBlockSize * 2))
                    let fullWidthItem = NSCollectionLayoutItem(layoutSize: fullWidthItemSize)
                    fullWidthItem.contentInsets = gridItemInsets
                    
                    let verticalAndFeatureGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(gridBlockSize * 2))
                    let verticalAndFeatureGroupA = NSCollectionLayoutGroup.horizontal(layoutSize: verticalAndFeatureGroupSize, subitems: isWide ? [verticalGroup, verticalGroup, featureItem, verticalGroup] : [verticalGroup, featureItem])
                    let verticalAndFeatureGroupB = NSCollectionLayoutGroup.horizontal(layoutSize: verticalAndFeatureGroupSize, subitems: isWide ? [verticalGroup, featureItem, verticalGroup, verticalGroup] : [featureItem, verticalGroup])
                    
                    let rowGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(gridBlockSize))
                    let rowGroup = NSCollectionLayoutGroup.horizontal(layoutSize: rowGroupSize, subitem: item, count: isWide ? 5 : 3)
                    
                    let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(gridBlockSize * 8))
                    let outerGroup = NSCollectionLayoutGroup.vertical(layoutSize: outerGroupSize, subitems: [verticalAndFeatureGroupA, rowGroup, fullWidthItem, verticalAndFeatureGroupB, rowGroup])
                    
                    let section = NSCollectionLayoutSection(group: outerGroup)
                    return section
            }
        }
    }
}

//struct GridView_Previews: PreviewProvider
//{
//	static var previews: some View
//	{
//		PhotoGridScreen()
//	}
//}





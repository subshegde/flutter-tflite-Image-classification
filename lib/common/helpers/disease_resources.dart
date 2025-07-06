  Map<String, List<Map<String, String>>> getDiseaseLinks(String label) {
    final normalized = label.toLowerCase().trim();
    switch (normalized) {
      case 'healthy':
        return {
          'YouTube': [
            {
              'title':'Benefits of Mango Leaves | Health Benefits of Mango Leaves',
              'id': 'wEGe7uQt-zc',
              'source': 'Health Tips',
            },
            {
              'title': 'Mango Tree Care Tips for Optimal Health',
              'id': 'CmRA585kZI0',
              'source': 'Gardening Basics',
            },
          ],
          'Articles': [
            {
              'title': 'Nutritional Health Benefits and Bioactive Compounds of Mangifera indica L (Mango) Leaves Methanolic Extracts ',
              'url': 'https://journalaprj.com/index.php/APRJ/article/view/92',
            },
            {
              'title': 'Mango Leaf: Health Benefits, Nutrition, Uses And Delectable Recipe Of These Tender Leaves',
              'url': 'https://www.netmeds.com/health-library/post/mango-leaf-health-benefits-nutrition-uses-and-delectable-recipe-of-these-tender-leaves?srsltid=AfmBOoptXSLdNojWn2Xg9KtDSGHNB8upRISnZf2aNRg5choP-8VNn8jB',
            },
          ],
        };
      case 'gall midge':
        return {
          'YouTube': [
            {
              'title': 'Managing Gall Midge in Mango Trees',
              'id': 'QK7m0OBPZ80',
              'source': 'Agricultural Extension',
            },
            {
              'title': 'Pest Control for Mango Gall Midge',
              'id': '4WP-HnDVc-c',
              'source': 'Plant Protection',
            },
          ],
          'Articles': [
            {
              'title': 'Mango midges: Procontarinia matteiana',
              'url': 'https://plantwiseplusknowledgebank.org/doi/full/10.1079/pwkb.20207800227',
            },
            {
              'title': 'Mango leaf gall midge',
              'url': 'https://www.business.qld.gov.au/industries/farms-fishing-forestry/agriculture/biosecurity/plants/priority-pest-disease/mango-leaf-gall-midge',
            },
          ],
        };
      case 'sooty mould':
        return {
          'YouTube': [
            {
              'title': 'Problems in Paradise - Black Sooty Mold in Mango Trees',
              'id': 'xi7GB_jynZY',
              'source': 'UF/IFAS Extension',
            },
            {
              'title': 'Black Sooty Mold on Mango Tree Easy Treatment',
              'id': '2q67JkXlWpE',
              'source': 'Gardening Tips',
            },
          ],
          'Articles': [
            {
              'title': 'Sooty Mould Mango Disease Management',
              'url': 'https://pestsdiseases.com/mango-sooty-mould-disease-management-symptoms-treatment-chemical-biological-natural-and-organic-control/#mango-sooty-mould-disease-management',
            },
            {
              'title': 'Mango: Diseases and symptoms',
              'url': 'https://agriculture.vikaspedia.in/viewcontent/agriculture/crop-production/integrated-pest-managment/ipm-for-fruit-crops/ipm-strategies-for-mango/mango-diseases-and-symptoms?lgn=en',
            }
          ],
        };
      default:
        return {'YouTube': [], 'Articles': []};
    }
  }
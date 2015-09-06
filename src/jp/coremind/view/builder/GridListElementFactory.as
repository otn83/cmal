package jp.coremind.view.builder
{
    import jp.coremind.model.Diff;
    import jp.coremind.model.ListDiff;
    import jp.coremind.model.StorageModelReader;
    import jp.coremind.view.abstract.IElement;
    import jp.coremind.view.layout.LayoutCalculator;
    
    /**
     */
    public class GridListElementFactory extends ListElementFactory
    {
        private var
            _densityList:Vector.<int>;
        
        public function GridListElementFactory()
        {
            _densityList = new <int>[];
        }
        
        override public function destroy():void
        {
            _densityList.length = 0;
            
            super.destroy();
        }
        
        override public function initialize(reader:StorageModelReader):void
        {
            super.initialize(reader);
            
            var dataList:Array = _reader.read();
            
            _densityList.length = 0;
            for (var i:int = 0, len:int = dataList.length; i < len; i++) 
                _pushDensity(_densityList, dataList[i], i, len);
        }
        
        override public function preview(plainDiff:Diff):void
        {
            var diff:ListDiff = plainDiff as ListDiff;
            var dataList:Array = diff.editedOrigin;
            
            _densityList.length = 0;
            for (var i:int = 0, len:int = dataList.length; i < len; i++)
                _pushDensity(_densityList, dataList[ diff.order[i] ], i, len);
        }
        
        override public function elementInitializer(element:IElement, builder:ElementBuilder, actualParentWidth:int, actualParentHeight:int, modelData:*, index:int, length:int):void
        {
            var calculator:LayoutCalculator = builder.requestLayoutCalculator();
            
            element.initialize(_reader.id + "." + index);
            element.initializeElementSize(
                calculator.width.calc(actualParentWidth),
                calculator.height.calc(actualParentHeight));
        }
        
        /**
         * グリッド密度リストを返す.
         */
        public function get densityList():Vector.<int>
        {
            return _densityList;
        }
        
        protected function _pushDensity(densityList:Vector.<int>, modelData:*, index:int, length:int):void
        {
            densityList.push(1, 1);
        }
    }
}
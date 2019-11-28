jflex syntax/FnPlotLexer.jflex
cup -parser FnPlotParser -destdir syntax syntax/FnPlotParser.cup
javac -cp ".:/usr/share/java/cup.jar:cs34g.gfx.jar" syntax/*.java semantics/*.java sys/*.java gui/*.java values/*.java 
# java -cp ".:/usr/share/java/cup.jar:cs34g.gfx.jar" fnplot.gui.FnPlotFrame

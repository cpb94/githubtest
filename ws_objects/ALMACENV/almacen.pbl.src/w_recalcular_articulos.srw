$PBExportHeader$w_recalcular_articulos.srw
forward
global type w_recalcular_articulos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_recalcular_articulos
end type
type dw_listado from datawindow within w_recalcular_articulos
end type
type st_1 from statictext within w_recalcular_articulos
end type
type cb_1 from u_boton within w_recalcular_articulos
end type
type dw_proceso from datawindow within w_recalcular_articulos
end type
type articulo from statictext within w_recalcular_articulos
end type
type descripcion from statictext within w_recalcular_articulos
end type
type st_2 from statictext within w_recalcular_articulos
end type
type metrosl from statictext within w_recalcular_articulos
end type
type st_3 from statictext within w_recalcular_articulos
end type
type piezas from statictext within w_recalcular_articulos
end type
type st_4 from statictext within w_recalcular_articulos
end type
type st_5 from statictext within w_recalcular_articulos
end type
type largo from statictext within w_recalcular_articulos
end type
type ancho from statictext within w_recalcular_articulos
end type
type st_14 from statictext within w_recalcular_articulos
end type
type formato from statictext within w_recalcular_articulos
end type
type st_12 from statictext within w_recalcular_articulos
end type
type peso from statictext within w_recalcular_articulos
end type
type cb_2 from u_boton within w_recalcular_articulos
end type
type cb_compras from u_boton within w_recalcular_articulos
end type
end forward

global type w_recalcular_articulos from w_int_con_empresa
int Width=2784
int Height=952
pb_1 pb_1
dw_listado dw_listado
st_1 st_1
cb_1 cb_1
dw_proceso dw_proceso
articulo articulo
descripcion descripcion
st_2 st_2
metrosl metrosl
st_3 st_3
piezas piezas
st_4 st_4
st_5 st_5
largo largo
ancho ancho
st_14 st_14
formato formato
st_12 st_12
peso peso
cb_2 cb_2
cb_compras cb_compras
end type
global w_recalcular_articulos w_recalcular_articulos

type variables



end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Recalculo datos articulos"
This.title=istr_parametros.s_titulo_ventana
dw_proceso.SetTransObject(SQLCA)


end event

on w_recalcular_articulos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_proceso=create dw_proceso
this.articulo=create articulo
this.descripcion=create descripcion
this.st_2=create st_2
this.metrosl=create metrosl
this.st_3=create st_3
this.piezas=create piezas
this.st_4=create st_4
this.st_5=create st_5
this.largo=create largo
this.ancho=create ancho
this.st_14=create st_14
this.formato=create formato
this.st_12=create st_12
this.peso=create peso
this.cb_2=create cb_2
this.cb_compras=create cb_compras
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_proceso
this.Control[iCurrent+6]=this.articulo
this.Control[iCurrent+7]=this.descripcion
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.metrosl
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.piezas
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.largo
this.Control[iCurrent+15]=this.ancho
this.Control[iCurrent+16]=this.st_14
this.Control[iCurrent+17]=this.formato
this.Control[iCurrent+18]=this.st_12
this.Control[iCurrent+19]=this.peso
this.Control[iCurrent+20]=this.cb_2
this.Control[iCurrent+21]=this.cb_compras
end on

on w_recalcular_articulos.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_proceso)
destroy(this.articulo)
destroy(this.descripcion)
destroy(this.st_2)
destroy(this.metrosl)
destroy(this.st_3)
destroy(this.piezas)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.largo)
destroy(this.ancho)
destroy(this.st_14)
destroy(this.formato)
destroy(this.st_12)
destroy(this.peso)
destroy(this.cb_2)
destroy(this.cb_compras)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_recalcular_articulos
int TabOrder=20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_recalcular_articulos
int TabOrder=40
end type

type st_empresa from w_int_con_empresa`st_empresa within w_recalcular_articulos
int X=27
int Y=8
int Width=2427
boolean BringToTop=true
end type

type pb_1 from upb_salir within w_recalcular_articulos
int X=2574
int Y=8
int Width=137
int Height=120
int TabOrder=0
end type

type dw_listado from datawindow within w_recalcular_articulos
int X=215
int Width=494
int Height=152
int TabOrder=60
boolean Visible=false
boolean BringToTop=true
string DataObject="report_articulos_anulados"
boolean LiveScroll=true
end type

type st_1 from statictext within w_recalcular_articulos
int X=55
int Y=188
int Width=256
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Articulo:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_boton within w_recalcular_articulos
int X=2121
int Y=184
int TabOrder=30
string Text="Procesar"
end type

event clicked;call super::clicked;f_mensaje("Opcion bloqueada","No se puede procesar")

//Integer reg,reg1
//Dec{3} peso_caja,peso_envase,peso_piezas,metros_caja,metrosl_caja,var_piezas,var_peso_pieza,var_largo,var_ancho
//String cod_formato,var_empresa
//
//reg= dw_proceso.Retrieve()
//For reg1 = 1 To reg
//	var_empresa      = f_valor_columna(dw_proceso,reg1,"empresa")
//	articulo.text    = f_valor_columna(dw_proceso,reg1,"codigo")
//	descripcion.text = f_valor_columna(dw_proceso,reg1,"descripcion")
//
//	
//
//var_piezas     = Dec(f_valor_columna(dw_proceso,reg1,"piezascaja"))
//piezas.text = String(var_piezas)
//var_peso_pieza = Dec(f_valor_columna(dw_proceso,reg1,"pesopieza"))
//peso_piezas = var_peso_pieza  * var_piezas
//peso_envase     = Dec(f_valor_columna(dw_proceso,reg1,"pesoenvase"))
//cod_formato     = f_valor_columna(dw_proceso,reg1,"formato")
//formato.text    = f_nombre_formato(var_empresa,cod_formato)
//peso_caja  = peso_envase + peso_piezas
//peso.text  = String(peso_caja)
// 
//       var_largo = f_largo_formato(var_empresa,cod_formato)
//		 largo.text= String(var_largo)
//       var_ancho = f_ancho_formato(var_empresa,cod_formato)
//		 ancho.text= String(var_ancho)
//
//       metrosl_caja = (var_piezas * var_largo)/100
//		 metrosl.text= String(metrosl_caja)
//       
//
//IF IsNull(var_largo)  Then var_largo   = 0
//IF IsNull(var_ancho)  Then var_ancho   = 0
//IF IsNull(var_piezas) Then var_piezas  = 0
//IF var_piezas = 0 Then
//  f_mensaje("Error en datos del articulo",descripcion.text)
//END IF
//IF var_largo = 0  or var_ancho = 0 Then
//  f_mensaje("Error en datos del formato",formato.text)
//ELSE
//	Update articulos  
//Set metroslcaja = :metrosl_caja,
//    pesocaja    = :peso_caja
//Where   empresa = :var_empresa
//And     codigo = :articulo.text;
//Commit;
//END IF
//	f_contador_procesos(reg1,reg)
//Next
end event

type dw_proceso from datawindow within w_recalcular_articulos
int X=960
int Width=494
int Height=176
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_proceso_articulos"
boolean LiveScroll=true
end type

type articulo from statictext within w_recalcular_articulos
int X=325
int Y=188
int Width=421
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type descripcion from statictext within w_recalcular_articulos
int X=754
int Y=188
int Width=1339
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=128
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_recalcular_articulos
int X=50
int Y=364
int Width=261
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Mtrs. Ln:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type metrosl from statictext within w_recalcular_articulos
int X=325
int Y=364
int Width=421
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_recalcular_articulos
int X=87
int Y=276
int Width=229
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Piezas:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type piezas from statictext within w_recalcular_articulos
int X=325
int Y=276
int Width=421
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_recalcular_articulos
int X=809
int Y=452
int Width=210
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Largo:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_recalcular_articulos
int X=1495
int Y=452
int Width=215
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Ancho:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type largo from statictext within w_recalcular_articulos
int X=1019
int Y=452
int Width=421
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ancho from statictext within w_recalcular_articulos
int X=1723
int Y=452
int Width=421
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within w_recalcular_articulos
int X=37
int Y=452
int Width=274
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Formato:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type formato from statictext within w_recalcular_articulos
int X=325
int Y=452
int Width=421
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within w_recalcular_articulos
int X=837
int Y=364
int Width=174
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Peso:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type peso from statictext within w_recalcular_articulos
int X=1019
int Y=364
int Width=421
int Height=72
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from u_boton within w_recalcular_articulos
event clicked pbm_bnclicked
int X=2121
int Y=292
int TabOrder=10
string Text="Asignar Tono"
end type

event clicked;call super::clicked;Integer reg,reg1
Dec{3}  peso_caja,peso_envase,peso_piezas,metros_caja,metrosl_caja,var_piezas,var_peso_pieza,var_largo,var_ancho
String  cod_formato,var_empresa,familia,tono,calibre

reg= dw_proceso.Retrieve(codigo_empresa)
For reg1 = 1 To reg
	var_empresa      = f_valor_columna(dw_proceso,reg1,"empresa")
	articulo.text    = f_valor_columna(dw_proceso,reg1,"codigo")
	familia    = f_valor_columna(dw_proceso,reg1,"familia")
	descripcion.text = f_valor_columna(dw_proceso,reg1,"descripcion")

	

Select  tono,calibre Into :tono,:calibre From familias
Where   empresa = :codigo_empresa
And     codigo = :familia;
piezas.text = String(var_piezas)
Update articulos  
Set 	tono        = :tono,
    	calibre     = :calibre
Where   empresa = :var_empresa
And     codigo = :articulo.text;
Commit;

	f_contador_procesos(reg1,reg)
Next
end event

type cb_compras from u_boton within w_recalcular_articulos
event clicked pbm_bnclicked
int X=2158
int Y=412
int Width=489
int TabOrder=12
string Text="Asignar Compras"
end type

event clicked;Dec r , r1,numero
String  varticulo,compra
DataStore data

//data = f_cargar_cursor("Select * from articulos")
f_cargar_cursor_nuevo("Select * from articulos", data)


r1 = data.RowCount()
For r = 1 To r1
	varticulo = data.GetItemString(r,"codigo")
  SELECT count(*)    INTO :numero     FROM decoradospro  
   WHERE  decoradospro.articulo = :varticulo 
	AND    decoradospro.tratamiento = 'N' ;
	iF IsNUll(numero) Then numero = 0
	IF numero = 0 Then
		compra = "N"
	ELSE
		compra = "S"
	END IF
	Update  articulos Set articulos.compras = :compra
	Where   articulos.empresa = :codigo_empresa
	And     articulos.codigo  = :varticulo;
	COMMIT;
	f_contador_procesos(r,r1)
Next

destroy data
end event


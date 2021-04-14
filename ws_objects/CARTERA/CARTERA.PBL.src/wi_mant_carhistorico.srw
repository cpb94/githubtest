$PBExportHeader$wi_mant_carhistorico.srw
$PBExportComments$€
forward
global type wi_mant_carhistorico from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_carhistorico
end type
type em_anyo from u_em_campo within wi_mant_carhistorico
end type
type st_ntelefonos from statictext within wi_mant_carhistorico
end type
type gb_1 from groupbox within wi_mant_carhistorico
end type
type st_2 from statictext within wi_mant_carhistorico
end type
type st_lin from statictext within wi_mant_carhistorico
end type
type cb_reactivar_efecto from commandbutton within wi_mant_carhistorico
end type
end forward

shared variables

end variables

global type wi_mant_carhistorico from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 3675
integer height = 2028
pb_calculadora pb_calculadora
em_anyo em_anyo
st_ntelefonos st_ntelefonos
gb_1 gb_1
st_2 st_2
st_lin st_lin
cb_reactivar_efecto cb_reactivar_efecto
end type
global wi_mant_carhistorico wi_mant_carhistorico

type variables
	// Tipo Tercero

string ic_tipoter
datawindowchild idwc_nompro
datawindowchild idwc_codpostal
datawindowchild idwc_codpais,idwc_codmoneda
dec linea=1
dec linea_max
end variables

event open;call super::open;pb_calculadora.visible=FALSE

istr_parametros.s_titulo_ventana = "Mantenimiento historico efectos"
//istr_parametros.s_listado        = "report_carefectos"

This.title=istr_parametros.s_titulo_ventana

em_anyo.text=string(year(today()))
f_mascara_columna(dw_1,"anyofra",f_mascara_decimales(0))
f_mascara_columna(dw_1,"factura",f_mascara_decimales(0))
f_mascara_columna(dw_1,"recibo",f_mascara_decimales(0))
f_mascara_columna(dw_1,"importe",f_mascara_decimales(0))
f_mascara_columna(dw_1,"divisas",f_mascara_decimales(2))
f_mascara_columna(dw_1,"remesa",f_mascara_decimales(0))
f_mascara_columna(dw_1,"efectoagrupa",f_mascara_decimales(0))
f_mascara_columna(dw_1,"anyoagrupa",f_mascara_decimales(0))


  // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      em_anyo.text   = istr_parametros.s_argumentos[2]
		sle_valor.text = istr_parametros.s_argumentos[3]
		linea          = dec(istr_parametros.s_argumentos[4])
		istr_parametros.i_nargumentos=0
		IF Trim(em_anyo.text)<>""and Not IsNull(em_anyo.text)and Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		   sle_valor.TriggerEvent("modificado")
			This.triggerevent("ue_recuperar")
     END IF 
	END IF

f_activar_campo(sle_valor)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title

 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(trim(em_anyo.text))
 criterio[2]  =  trim(em_anyo.text)+space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[3]  =  trim(sle_valor.text)+space(20-longitud)
 
 seleccion    =  criterio[1]+criterio[2]+criterio[3]

 tabla        = "carhistorico"

 dw_1.Retrieve(codigo_empresa,dec(em_anyo.text),dec(sle_valor.text),linea)
 CALL Super::ue_recuperar



end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"anyo",dec(em_anyo.text))
dw_1.setitem(dw_1.getrow(),"orden",dec(sle_valor.text))
dw_1.setitem(dw_1.getrow(),"linea",linea)






end event

event ue_desactiva_claves;call super::ue_desactiva_claves;
		// Activamos los campos clave añadidos


sle_valor.enabled   = FALSE
em_anyo.enabled   = FALSE
pb_calculadora.visible=FALSE
end event

event ue_activa_claves;call super::ue_activa_claves;
		// Activamos los campos clave añadidos

sle_valor.enabled = TRUE
em_anyo.enabled   = TRUE
pb_calculadora.visible = TRUE
end event

on wi_mant_carhistorico.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.em_anyo=create em_anyo
this.st_ntelefonos=create st_ntelefonos
this.gb_1=create gb_1
this.st_2=create st_2
this.st_lin=create st_lin
this.cb_reactivar_efecto=create cb_reactivar_efecto
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.em_anyo
this.Control[iCurrent+3]=this.st_ntelefonos
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_lin
this.Control[iCurrent+7]=this.cb_reactivar_efecto
end on

on wi_mant_carhistorico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.em_anyo)
destroy(this.st_ntelefonos)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.st_lin)
destroy(this.cb_reactivar_efecto)
end on

event ue_borra_fila;long     anyo,orden,ll_linea,orden_nueva,indice2,total2
string   historico,agrupado,sel
dec      importe_devuelto,divisas_devueltas,importe,divisas
boolean  bien = true

//Estructuras
str_carefectos   carefectos
str_carhistorico carhistorico
//Cursor
datastore ds_detalle_agrupado

anyo     = dw_1.object.anyo[1] 
orden    = dw_1.object.orden[1]
ll_linea = dw_1.object.linea[1]
	
if not(f_cargar_str_carhistorico(codigo_empresa,anyo,orden,ll_linea,carhistorico)) then
	bien = false
else
	f_pasa_str_carhistorico_a_str_carefectos(carhistorico,carefectos)		
		
	if carefectos.situacion = '3' then
		bien = false
		messagebox("Atención","No se puede eliminar el detalle de un efecto agrupado.")
	else		
		carefectos.orden     = f_orden_carparam(carefectos.empresa,carefectos.anyo)
		//carefectos.situacion = '0'
		
		if not(f_insert_carefectos(carefectos)) then
			bien = false
		end if
		
		if carefectos.agrupado = "S" then
			orden_nueva = carefectos.orden
			
			sel = "select anyo,orden,linea "+&
					"from   carhistorico "+&
					"where  empresa      = '"+codigo_empresa+"' "+&
					"and    situacion    = '3' "+&
					"and    anyoagrupa   = "+string(anyo,"###0")+" "+&
					"and    efectoagrupa = "+string(orden,"#####0")+" "+&
					"and    linea        = "+string(ll_linea,"###0")+" "
					
			ds_detalle_agrupado = f_cargar_cursor(sel)
			
			total2 = ds_detalle_agrupado.rowcount()
			
			if total2 > 0 then
				//Pasamos el detalle del agrupado a cartera
				for indice2 = 1 to total2
					anyo  = ds_detalle_agrupado.object.anyo[indice2] 
					orden = ds_detalle_agrupado.object.orden[indice2]
					ll_linea = ds_detalle_agrupado.object.linea[indice2]				
					
					f_cargar_str_carhistorico(codigo_empresa,anyo,orden,ll_linea,carhistorico)
					
					f_pasa_str_carhistorico_a_str_carefectos(carhistorico,carefectos)			
					
					carefectos.orden        = f_orden_carparam(carefectos.empresa,carefectos.anyo)
					carefectos.efectoagrupa = orden_nueva
					
					if not(f_insert_carefectos(carefectos)) then
						bien = false
					end if						
				next
			else
				bien = false
				messagebox("Atención!!","Agrupado sin detalle.")
			end if
			
			destroy ds_detalle_agrupado
		end if
	end if
end if

if bien then
	call super::ue_borra_fila
else
	rollback;
	messagebox("Atención","No se elimina el registro.")
end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_carhistorico
integer x = 27
integer y = 280
integer width = 3557
integer height = 1508
string dataobject = "dw_carhistorico"
boolean border = true
end type

event dw_1::key; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "fpago"
      bus_datawindow = "dw_ayuda_carforpag"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION DE FORMAS DE PAGO"

CASE "cliente"
      bus_datawindow = "dw_ayuda_clientes"
      bus_titulo = "VENTANA SELECCION DE CLIENTES"
     valor_empresa = true
		
		
		
	CASE "tipodoc"
      bus_datawindow = "dw_ayuda_cartipodoc"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION TIPOS DE DOCUMENTOS"	
	CASE "monedas"
      bus_datawindow = "dw_ayuda_divisas"
      bus_titulo = "VENTANA SELECCION DE MONEDAS"
		valor_empresa = FALSE
   CASE "cuenta"
      bus_datawindow = "dw_ayuda_contaplan"
      bus_titulo = "VENTANA SELECCION DE CUENTAS"
		valor_empresa = true
	CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
      bus_titulo = "VENTANA SELECCION DE AGENTES"
		valor_empresa = true	
	CASE "situacion"
      bus_datawindow = "dw_ayuda_carsituacion"
      bus_titulo = "VENTANA SELECCION DE SITUACIÓN"
		valor_empresa = true	
   CASE "domiciliacion"
      bus_datawindow = "dw_ayuda_vendomiciliacion"
      bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		valor_empresa = true	
	CASE "banco"
      bus_datawindow = "dw_ayuda_carbancos"
      bus_titulo = "VENTANA SELECCION DE BANCO"
		valor_empresa = true					      
	CASE "banco_docu"
      bus_datawindow = "dw_ayuda_carbancos"
      bus_titulo = "VENTANA SELECCION DE BANCO"
		valor_empresa = true					     		

		
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

event dw_1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
//      f_valores_numericos(dw_1,"anyofra")
//       f_valores_numericos(dw_1,"factura")
//		  f_valores_numericos(dw_1,"recibo")
//		   f_valores_numericos(dw_1,"importe")
//			 f_valores_numericos(dw_1,"remesa")
//			  f_valores_numericos(dw_1,"efectoagrupa")
//			   f_valores_numericos(dw_1,"anyoagrupa")
//				 
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_1::clicked;call super::clicked;valor_empresa = TRUE
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_carefectos"

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_linea'
	linea=linea+1
	if linea>linea_max then linea=1
	dw_1.Retrieve(codigo_empresa,dec(em_anyo.text),dec(sle_valor.text),linea)
CASE 'pb_pais'
	valor_empresa = FALSE
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"pais")
   OpenWithParm(wi_mant_paises,lstr_param)  
      
CASE 'pb_cuenta'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cuenta")
   OpenWithParm(wi_mant_contaplan,lstr_param)  
CASE 'pb_agente'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente1")
   OpenWithParm(wi_mant_venagentes,lstr_param)  
CASE 'pb_tipodoc'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipodoc")
   OpenWithParm(wi_mant_cartipodoc,lstr_param)  
CASE 'pb_fpago'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"fpago")
   OpenWithParm(wi_mant_carforpag,lstr_param)  
CASE 'pb_monedas'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"monedas")
   OpenWithParm(wi_mant_divisas,lstr_param)  
CASE 'pb_situacion'
	valor_empresa = FALSE
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"situacion")
   OpenWithParm(wi_mant_carsituacion,lstr_param)  
CASE "pb_domi"
	valor_empresa = false
 	lstr_param.i_nargumentos    = 3
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
 	lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
 	OpenWithParm(wi_mant_vendomiciliacion,lstr_param)
CASE "pb_banco"
	valor_empresa = false
 	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"banco")
 	OpenWithParm(wi_mant_carbancos,lstr_param)
CASE "pb_banco_docu"
	valor_empresa = false
 	lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"banco_docu")
 	OpenWithParm(wi_mant_carbancos,lstr_param)	 
END CHOOSE



end event

event dw_1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "pais"
 		bus_datawindow = "dw_ayuda_paises"
		bus_titulo = "VENTANA SELECCION DE PAISES"
		valor_empresa = FALSE
   CASE "fpago"
      bus_datawindow = "dw_ayuda_carforpag"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION DE FORMAS DE PAGO"

   CASE "cliente"
		bus_datawindow = "dw_ayuda_clientes"
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
		valor_empresa = true
		
		
	CASE "tipodoc"
      bus_datawindow = "dw_ayuda_cartipodoc"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION TIPOS DE DOCUMENTOS"	
	CASE "monedas"
      bus_datawindow = "dw_ayuda_divisas"
      bus_titulo = "VENTANA SELECCION DE MONEDAS"
		valor_empresa = FALSE
   CASE "cuenta"
      bus_datawindow = "dw_ayuda_contaplan"
      bus_titulo = "VENTANA SELECCION DE CUENTAS"
		valor_empresa = true
	CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
      bus_titulo = "VENTANA SELECCION DE AGENTES"
		valor_empresa = true	
	CASE "situacion"
      bus_datawindow = "dw_ayuda_carsituacion"
      bus_titulo = "VENTANA SELECCION DE SITUACIÓN"
		valor_empresa = true	
   CASE "domiciliacion"
      bus_datawindow = "dw_ayuda_vendomiciliacion"
      bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
		bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		valor_empresa = true	
	CASE "banco"
      bus_datawindow = "dw_ayuda_carbancos"
      bus_titulo = "VENTANA SELECCION DE BANCO"
		valor_empresa = true		
	CASE "banco_docu"
      bus_datawindow = "dw_ayuda_carbancos"
      bus_titulo = "VENTANA SELECCION DE BANCO"
		valor_empresa = true			   	   
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown


end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_carhistorico
integer x = 14
integer y = 160
integer width = 151
integer height = 68
string text = "Año:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_carhistorico
integer x = 2455
integer y = 140
integer width = 375
integer height = 96
end type

event cb_insertar::clicked;iF cb_insertar.enabled =TRUE THEN 
	dw_1.AcceptText()
   string fpago
	fpago=dw_1.GetitemString(dw_1.Getrow(),"fpago")
	dw_1.setitem(dw_1.getrow(),"tipodoc",f_tipodoc_carforpag(codigo_empresa,fpago))
END IF

call super::clicked


end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_carhistorico
integer x = 2830
integer y = 140
integer width = 375
integer height = 96
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_carhistorico
integer x = 645
integer y = 148
integer width = 311
integer taborder = 30
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = ""
end type

event sle_valor::getfocus;call super::getfocus;if Trim(em_anyo.text)="" then
        f_activar_campo(em_anyo)	
        RETURN
end iF

pb_calculadora.visible=TRUE



end event

event sle_valor::rbuttondown;call super::rbuttondown;return
end event

event sle_valor::tecla_enter;call super::tecla_enter;return
end event

event sle_valor::modificado;call super::modificado;
	dec anyo_efecto,orden_efecto
	
	anyo_efecto  = dec(em_anyo.text)
	orden_efecto = dec(sle_valor.text)
	
	SELECT max(carhistorico.linea )  
   INTO 	 :linea_max
   FROM   carhistorico  
   WHERE ( carhistorico.empresa = :codigo_empresa ) AND  
         ( carhistorico.anyo    = :anyo_efecto ) AND  
         ( carhistorico.orden   = :orden_efecto )   ;
			
st_2.text=string(integer(linea_max))


end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_carhistorico
integer x = 3205
integer y = 140
integer width = 375
integer height = 96
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_carhistorico
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_carhistorico
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_carhistorico
integer x = 5
integer y = 12
integer width = 3589
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type pb_calculadora from u_calculadora within wi_mant_carhistorico
integer x = 960
integer y = 140
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return

Integer registros,var_orden,var_anyo


var_anyo = dec(em_anyo.text)
var_orden = f_orden_carparam(codigo_empresa,var_anyo)

//Select count(*) Into :registros From carefectos
//Where  carefectos.empresa       = :codigo_empresa
//and    carefectos.anyo    = :var_anyo;
//
//IF registros=0 THEN
// sle_valor.text="1" 
//ELSE
// Select max(convert(int,carefectos.orden)+1)
// Into   :var_orden
// From   carefectos
// Where  carefectos.empresa       = :codigo_empresa
// and    carefectos.anyo       = :var_anyo;
// sle_valor.text=string(var_orden)
//END IF

sle_valor.text=string(var_orden)

dw_1.TriggerEvent("Clicked")
end event

type em_anyo from u_em_campo within wi_mant_carhistorico
integer x = 174
integer y = 148
integer width = 233
integer taborder = 10
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
string displaydata = "~r"
end type

event getfocus;call super::getfocus;pb_calculadora.visible=FALSE
dw_1.reset()

IF istr_parametros.i_nargumentos>1 THEN
	  em_anyo.text=istr_parametros.s_argumentos[2]
     sle_valor.text=istr_parametros.s_argumentos[3]
 	  istr_parametros.i_nargumentos=0
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
  			This.TriggerEvent("Modificado")
			Parent.TriggerEvent("ue_recuperar")
			f_activar_campo(sle_valor)
			return
     END IF     
	  
ELSE
     Sle_valor.text = ""
END IF


end event

event rbuttondown;call super::rbuttondown;return
end event

event tecla_enter;call super::tecla_enter;return
end event

type st_ntelefonos from statictext within wi_mant_carhistorico
integer x = 1134
integer y = 156
integer width = 293
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Lineas:"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within wi_mant_carhistorico
integer x = 1824
integer y = 108
integer width = 1769
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within wi_mant_carhistorico
integer x = 1435
integer y = 148
integer width = 142
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_lin from statictext within wi_mant_carhistorico
integer x = 425
integer y = 160
integer width = 219
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Orden:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_reactivar_efecto from commandbutton within wi_mant_carhistorico
integer x = 1838
integer y = 140
integer width = 581
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reactivar Efecto"
end type

event clicked;boolean continuar = true

if messagebox ("Atención", '¿Seguro que desea devolver el efecto como pdte. de cobro?. ~n Quedará en situación "EN CARTERA" ~n Pasará a Agrupado NO.', Question!, YesNo!) = 1 then
		//Evento del boton de borra sin mensaje
     IF NOT f_bloquear(tabla,seleccion,titulo) THEN
     CALL Super::clicked
     Parent.TriggerEvent("ue_borra_fila")
     IF dw_1.Update() = 1 THEN 
		 Commit using sqlca;
     ELSE		
	   RollBack using sqlca;
     END IF
	   sle_valor.text = ""
      Parent.TriggerEvent("ue_desbloquear")
      cb_insertar.Enabled = FALSE
		cb_borrar.Enabled = FALSE
      Parent.TriggerEvent("ue_recuperar")
     END IF
	  
//	INSERT INTO carefectos
//		(carefectos.empresa,
//		 carefectos.anyo,
//		 carefectos.orden,
//		 carefectos.anyofra,
//		 carefectos.factura,
//		 carefectos.recibo,
//		 carefectos.fvto,
//		 carefectos.fvto_original,
//		 carefectos.ffra,
//		 carefectos.fcobro,
//		 carefectos.importe,
//		 carefectos.divisas,
//		 carefectos.monedas,
//		 carefectos.fpago,
//		 carefectos.tipodoc,
//		 carefectos.banco,
//		 carefectos.remesa,
//		 carefectos.fremesa,
//		 carefectos.situacion,
//		 carefectos.agente1,
//		 carefectos.pais,
//		 carefectos.cuenta,
//		 carefectos.domiciliacion,
//		 carefectos.Nacional,
//		 carefectos.observaciones,
//		 carefectos.libre,
//		 carefectos.gasto,
//		 carefectos.fdevolucion,
//		 carefectos.agrupado,
//		 carefectos.efectoagrupa,
//		 carefectos.anyoagrupa,
//		 carefectos.cliente,
//		 carefectos.anyo_remesa,
//		 carefectos.comision11,
//		 carefectos.comision12,
//		 carefectos.agente2,
//		 carefectos.comision21,
//		 carefectos.comision22,
//		 carefectos.agente3,
//		 carefectos.comision31,
//		 carefectos.comision32,
//		 carefectos.cambio,
//		 carefectos.serie,
//		 carefectos.remesa_total,
//		 carefectos.tipo_remesa,
//		 carefectos.veces,
//		 carefectos.fechaimp,
//		 carefectos.nomcli,
//		 carefectos.domicli,
//		 carefectos.poblacli,
//		 carefectos.paiscli,
//		 carefectos.nombanco,
//		 carefectos.dirbanco1,
//		 carefectos.dirbanco2,
//		 carefectos.recibir_dmto,
//		 carefectos.fecha_recibido,
//		 carefectos.punteado,
//		 carefectos.clase_efecto,
//		 carefectos.cambio_euros,
//		 carefectos.cambio_asegurado,
//		 carefectos.devuelto_notificado_agente,
//		 carefectos.devuelto_notificado_agente2,
//		 carefectos.devuelto_notificado_agente3,
//		 carefectos.banco_docu)
//
//SELECT carhistorico.empresa,
//		 carhistorico.anyo,
//		 carhistorico.orden,
//		 carhistorico.anyofra,
//		 carhistorico.factura,
//		 carhistorico.recibo,
//		 carhistorico.fvto,
//		 carhistorico.fvto_original,
//		 carhistorico.ffra,
//		 carhistorico.fcobro,
//		 carhistorico.importe,
//		 carhistorico.divisas,
//		 carhistorico.monedas,
//		 carhistorico.fpago,
//		 carhistorico.tipodoc,
//		 carhistorico.banco,
//		 carhistorico.remesa,
//		 carhistorico.fremesa,
//		 isnull(carhistorico.situacion_anterior,carhistorico.situacion),
//		 carhistorico.agente1,
//		 carhistorico.pais,
//		 carhistorico.cuenta,
//		 carhistorico.domiciliacion,
//		 carhistorico.Nacional,
//		 carhistorico.observaciones,
//		 carhistorico.libre,
//		 carhistorico.gasto,
//		 carhistorico.fdevolucion,
//		 carhistorico.agrupado,
//		 carhistorico.efectoagrupa,
//		 carhistorico.anyoagrupa,
//		 carhistorico.cliente,
//		 carhistorico.anyo_remesa,
//		 carhistorico.comision11,
//		 carhistorico.comision12,
//		 carhistorico.agente2,
//		 carhistorico.comision21,
//		 carhistorico.comision22,
//		 carhistorico.agente3,
//		 carhistorico.comision31,
//		 carhistorico.comision32,
//		 carhistorico.cambio,
//		 carhistorico.serie,
//		 carhistorico.remesa_total,
//		 carhistorico.tipo_remesa,
//		 carhistorico.veces,
//		 carhistorico.fechaimp,
//		 carhistorico.nomcli,
//		 carhistorico.domicli,
//		 carhistorico.poblacli,
//		 carhistorico.paiscli,
//		 carhistorico.nombanco,
//		 carhistorico.dirbanco1,
//		 carhistorico.dirbanco2,
//		 carhistorico.recibir_dmto,
//		 carhistorico.fecha_recibido,
//		 carhistorico.punteado,
//		 carhistorico.clase_efecto,
//		 carhistorico.cambio_euros,
//		 carhistorico.cambio_asegurado,
//		 carhistorico.devuelto_notificado_agente,
//		 carhistorico.devuelto_notificado_agente2,
//		 carhistorico.devuelto_notificado_agente3,
//		 carhistorico.banco_docu
//	FROM carhistorico
//	where empresa = :codigo_empresa
//	and anyo = :em_anyo.text
//	and orden = :sle_valor.text  using SQLCA;
//	
//	IF SQLCA.SQLCode = -1 THEN         
//		continuar = false
//		MessageBox("SQL error", SQLCA.SQLErrText)
//		rollback using SQLCA;
//	END IF
//
//
//	if continuar then
//		delete from carhistorico 
//		where empresa = :codigo_empresa
//		and anyo = :em_anyo.text
//		and orden = :sle_valor.text  using SQLCA;
//		
//		IF SQLCA.SQLCode = -1 THEN         
//			continuar = false
//		END IF
//	end if
//		
//	IF not continuar THEN         
//		MessageBox("SQL error", SQLCA.SQLErrText)
//		rollback using SQLCA;
//	ELSE
//		commit using SQLCA;
//		close(parent);
//	END IF
end if


end event


$PBExportHeader$wi_mant_venlintarifas.srw
$PBExportComments$Mant. lineas de tarifas.
forward
global type wi_mant_venlintarifas from wi_mvent_con_empresa
end type
type st_nombre_tarifa from statictext within wi_mant_venlintarifas
end type
type sle_fecha from u_em_campo within wi_mant_venlintarifas
end type
type st_2 from statictext within wi_mant_venlintarifas
end type
type em_tarifa from u_em_campo within wi_mant_venlintarifas
end type
type st_nombre_calidad from statictext within wi_mant_venlintarifas
end type
type st_3 from statictext within wi_mant_venlintarifas
end type
type dw_fechas from datawindow within wi_mant_venlintarifas
end type
type em_articulo from u_em_campo_2 within wi_mant_venlintarifas
end type
type dw_detalle from datawindow within wi_mant_venlintarifas
end type
end forward

global type wi_mant_venlintarifas from wi_mvent_con_empresa
integer width = 2779
integer height = 2576
st_nombre_tarifa st_nombre_tarifa
sle_fecha sle_fecha
st_2 st_2
em_tarifa em_tarifa
st_nombre_calidad st_nombre_calidad
st_3 st_3
dw_fechas dw_fechas
em_articulo em_articulo
dw_detalle dw_detalle
end type
global wi_mant_venlintarifas wi_mant_venlintarifas

type variables
String var_moneda,var_mascara
Dec{3} ante_precio,ante_precio_euros
Long ultima_fila_editada
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();Datetime fecha
IF sle_fecha.text = "00-00-00" Then
	dw_1.Reset()
Else	
 fecha = DateTime(Date(String(sle_fecha.Text)))

 dw_1.Retrieve(codigo_empresa,em_tarifa.text,fecha,em_articulo.em_codigo.text,sle_valor.text)
END IF


end subroutine

event ue_inserta_fila;call super::ue_inserta_fila;
dw_1.Setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.Setitem(dw_1.getrow(),"tarifa",em_tarifa.text)
dw_1.Setitem(dw_1.getrow(),"fecha",Datetime(Date(string(sle_fecha.text))))
dw_1.Setitem(dw_1.getrow(),"usuario",nombre_usuario)
dw_1.Setitem(dw_1.getrow(),"falta",DateTime(today(),now()))
dw_1.Setitem(dw_1.getrow(),"calidad",sle_valor.text)
dw_1.Setitem(dw_1.getrow(),"articulo",em_articulo.em_codigo.text)

dw_1.setitem(dw_1.getrow(),"montajeartcal",f_componer_artcal(em_articulo.em_codigo.text,sle_valor.text))
dw_1.setitem(dw_1.getrow(),"familia",f_familia_articulo(codigo_empresa,em_articulo.em_codigo.text))
dw_1.setitem(dw_1.getrow(),"formato",f_formato_articulo(codigo_empresa,em_articulo.em_codigo.text))
dw_1.setitem(dw_1.getrow(),"modelo",f_modelo_articulo(codigo_empresa,em_articulo.em_codigo.text))

dw_1.setitem(dw_1.getrow(),"listar","S")
dw_1.setitem(dw_1.getrow(),"activo","S")
dw_1.setitem(dw_1.getrow(),"excepcion","N")
If f_unidad_articulo(codigo_empresa,em_articulo.em_codigo.text) = "0" Then
   dw_1.setitem(dw_1.getrow(),"tipo_linea","2")
Else
	dw_1.setitem(dw_1.getrow(),"tipo_linea","1")
END IF	


dw_1.setitem(dw_1.getrow(),"descripcion",f_nombre_articulo(codigo_empresa,em_articulo.em_codigo.text))

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)

longitud      =  len(trim(em_tarifa.text))
criterio[2]   =  trim(em_tarifa.text)+space(20-longitud)

longitud      =  len(trim(sle_fecha.text))
criterio[3]   =  trim(sle_fecha.text)+space(20-longitud)

longitud      =  len(trim(em_articulo.em_codigo.text))
criterio[4]   =  trim(em_articulo.em_codigo.text)+space(20-longitud)

longitud      =  len(trim(sle_valor.text))
criterio[5]   =  trim(sle_valor.text)+space(20-longitud)

seleccion     =  criterio[1]+criterio[2]+criterio[3]+criterio[4]+criterio[5]


tabla         =  "venlintarifas"


f_control()

CALL Super::ue_recuperar
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento lineas tarifas"
istr_parametros.s_listado        = "report_venlitarifas"
This.title=istr_parametros.s_titulo_ventana
sle_fecha.text=String(today())
dw_fechas.SetTransobject(SQLCA)
dw_detalle.SetTransobject(SQLCA)
ultima_fila_editada = 0
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;datetime fecha
string familia,formato,subfamilia
int cuantos

fecha=datetime(date(sle_fecha.text))
familia=f_familia_articulo(codigo_empresa,em_articulo.em_codigo.text)
formato=f_formato_articulo(codigo_empresa,em_articulo.em_codigo.text)
subfamilia=f_subfamilia_articulo(codigo_empresa,em_articulo.em_codigo.text)

if isnull(subfamilia) then
	select count(*)
	into :cuantos
	from ventarfamfor
	where empresa=:codigo_empresa and
			tarifa=:em_tarifa.text and
			fecha=:fecha and
			familia=:familia and
			formato=:formato and
			calidad=:sle_valor.text and
			subfamilia is null;
else
	select count(*)
	into :cuantos
	from ventarfamfor
	where empresa=:codigo_empresa and
			tarifa=:em_tarifa.text and
			fecha=:fecha and
			familia=:familia and
			formato=:formato and
			calidad=:sle_valor.text and
			subfamilia=:subfamilia;
end if
		
if isnull(cuantos) then cuantos=0

if cuantos=0 then
	  INSERT INTO ventarfamfor  
				( empresa,   
				  tarifa,   
				  fecha,   
				  familia,   
				  formato,   
				  calidad,   
				  precio,   
				  subfamilia )  
	  VALUES ( :codigo_empresa,   
				  :em_tarifa.text ,   
				  :fecha,   
				  :familia,   
				  :formato,   
				  :sle_valor.text,   
				  0,   
				  :subfamilia )  ;
	if sqlca.sqlcode<>0 then
		f_mensaje("Atención","Error al insertar en Familia/Formato")
		rollback;
	else
		f_mensaje("Atención","Formato:"+f_nombre_formato(codigo_empresa,formato)+" se ha añadido a la tarifa")		
		commit;
	end if
	
end if



dw_detalle.Retrieve(codigo_empresa,em_tarifa.text, DateTime(Date(String(sle_fecha.Text))))
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_fecha.enabled   = FALSE
em_articulo.em_codigo.enabled = FALSE
em_tarifa.enabled   = FALSE
end event

on wi_mant_venlintarifas.create
int iCurrent
call super::create
this.st_nombre_tarifa=create st_nombre_tarifa
this.sle_fecha=create sle_fecha
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.st_nombre_calidad=create st_nombre_calidad
this.st_3=create st_3
this.dw_fechas=create dw_fechas
this.em_articulo=create em_articulo
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nombre_tarifa
this.Control[iCurrent+2]=this.sle_fecha
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_tarifa
this.Control[iCurrent+5]=this.st_nombre_calidad
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.dw_fechas
this.Control[iCurrent+8]=this.em_articulo
this.Control[iCurrent+9]=this.dw_detalle
end on

on wi_mant_venlintarifas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nombre_tarifa)
destroy(this.sle_fecha)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.st_nombre_calidad)
destroy(this.st_3)
destroy(this.dw_fechas)
destroy(this.em_articulo)
destroy(this.dw_detalle)
end on

event ue_activa_claves;call super::ue_activa_claves;sle_fecha.enabled   = TRUE
em_articulo.em_codigo.enabled = TRUE
em_tarifa.enabled   = TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venlintarifas
integer x = 32
integer y = 468
integer width = 1947
integer height = 280
string dataobject = "dw_venlintarifas"
borderstyle borderstyle = stylelowered!
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;Dec{2} var_precio,var_precio_euros
string var_tarifa,var_moneda_tarifa,modificado_precio,modificado_precio_euros

AcceptText()

var_tarifa = em_tarifa.text
var_moneda_tarifa = f_moneda_ventarifas(codigo_empresa,var_tarifa) 
IF insercion <> "S" Then
	var_precio       = GetItemNumber(getRow(),"precio")
	var_precio_euros = GetItemNumber(getRow(),"precio_euros")
	IF var_precio <> ante_precio or var_precio_euros <> ante_precio_euros Then
		SetItem(GetRow(),"excepcion","S")
		IF var_precio <> ante_precio then
			if var_moneda_tarifa = "1" then
				var_precio_euros = var_precio / 166.386
			else
				var_precio_euros = 0
			end if
			Setitem(GetRow(),"precio_euros",var_precio_euros)
		ELSE
			if var_moneda_tarifa = "1" then
				IF var_precio_euros <> ante_precio_euros then
					var_precio = var_precio_euros * 166.386
					Setitem(GetRow(),"precio",var_precio)
				END IF
			end if
		END IF
		ante_precio       = var_precio
		ante_precio_euros = var_precio_euros
	END IF
else
	var_precio       = GetItemNumber(getRow(),"precio")
	var_precio_euros = GetItemNumber(getRow(),"precio_euros")
	//En el evento itemfocuschanged del objecto dwo.name es que recibe el foco
	if dwo.name = "precio_euros" then
		if var_moneda_tarifa = "1" then
			var_precio_euros = var_precio / 166.386
		else
			var_precio_euros = 0
		end if
		Setitem(GetRow(),"precio_euros",var_precio_euros)
	end if
	IF dwo.name = "descripcion" Then
		IF var_moneda_tarifa = "1" then
			var_precio = round(var_precio_euros * 166.386,0)
			Setitem(GetRow(),"precio",var_precio)
		END IF
	END IF
	
	ante_precio       = var_precio
	ante_precio_euros = var_precio_euros
END IF
end event

event dw_1::getfocus;call super::getfocus;IF GetRow() = 0 Then Return
ante_precio = GetItemNumber(getRow(),"precio")
ante_precio_euros = GetItemNumber(getRow(),"precio_euros")
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venlintarifas
integer x = 160
integer y = 340
integer width = 256
integer height = 80
string text = "Calidad:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venlintarifas
integer x = 2121
integer y = 468
integer width = 562
end type

event cb_insertar::clicked;call super::clicked;datastore dw_proceso
dec cont, registros, total, total_tarifas
string sel, v_articulo, v_fecha_tar_activa, v_fecha_alta, articulo_calidad, v_formato, v_familia, v_usuario
dec{2} v_precio, v_ancho, v_largo, v_precio_base_c_r, v_valor_base_c_r, v_precio_base_l
dec{2} v_valor_base_l, v_precio_bizcocho, v_valor_bizcocho, v_valor_acabado, v_precio_acabado
string v_g2, v_g3, des_articulo, v_moneda
int bien

if dw_1.object.precio[dw_1.GetRow()] = 0  or isnull(dw_1.object.precio[dw_1.GetRow()]) then
	return
end if

if em_tarifa.text <> '5' then  // 5: tarifa de valoración de stock
	if MessageBox("Atención", "Se va a generar la tarifa de valoración de stock. "+& 
					  " ¿Desea continuar?.", Question!, YesNo!, 2) = 2 then
		return
	end if
	
	select activa 
	into :v_fecha_tar_activa
	from ventarifas
	where codigo = "5"
	and empresa = :codigo_empresa;
	
	delete from venlintarifas
	where empresa = :codigo_empresa
	and tarifa = '5'
	and articulo = :em_articulo.em_codigo.text;
	
	v_fecha_alta = String(Today(), "dd/mm/yy hh:mm:ss")
		
	sel = "select codigo, descripcion, formato, familia, usuario "+&
			"from articulos "+&
			"where codigo = '"+em_articulo.em_codigo.text+"'"+&
			"and empresa = "+codigo_empresa+";"
	
	//dw_proceso = f_cargar_cursor(sel)		
	f_Cargar_cursor_nuevo(sel, dw_proceso)
		
	registros = dw_proceso.rowcount()
		
	select precio_base_c_r, valor_base_c_r, precio_base_l, valor_base_l, precio_bizcocho, valor_bizcocho, valor_acabado
	into :v_precio_base_c_r, :v_valor_base_c_r, :v_precio_base_l, :v_valor_base_l, :v_precio_bizcocho, 
		  :v_valor_bizcocho, :v_valor_acabado
	from valoracionbases
	where empresa = :codigo_empresa
	and codigo = "1";
		
	IF registros > 0 Then
		FOR cont = 1 To registros
			v_articulo = dw_proceso.object.codigo[cont]
	
	//			select count(*)
	//			into :Total_tarifas
	//			from venlintarifas
	//			where empresa = :codigo_empresa
	//			and articulo = :v_articulo
	//			and tarifa = "5";
	
			articulo_calidad = v_articulo + "01"
			v_formato = dw_proceso.object.formato[cont] 
			v_familia = dw_proceso.object.familia[cont] 
			v_usuario = dw_proceso.object.usuario[cont] 
			
			select ancho, largo
			into :v_ancho, :v_largo
			from formatos
			where empresa = :codigo_empresa
			and   codigo = :v_formato;
			
			select g2, g3
			into :v_g2, :v_g3
			from art_codestadistico
			where empresa = :codigo_empresa
			and codigo = :v_articulo;
			
			des_articulo = dw_proceso.object.descripcion[cont] 
			des_articulo = left (des_articulo, 30)
			
				
			if (v_g2 = "B") and ((v_g3 = "C") or (v_g3 = "R")) then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_c_r * (1 - v_valor_base_c_r/100))
			elseif (v_g2 = "B") and ((v_g3 = "L") or (v_g3 = "P")) then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_l * (1 - v_valor_base_l/100))
			elseif (v_g2 = "Z") then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_bizcocho * (1 - v_valor_bizcocho/100))
			else
				v_precio_Acabado = 0
				select venlintarifas.precio, ventarifas.moneda
				into   :v_precio_acabado, :v_moneda
				from venlintarifas, ventarifas
				where venlintarifas.empresa = :codigo_empresa
				and ventarifas.empresa = :codigo_empresa
				and venlintarifas.articulo = :v_articulo
				and venlintarifas.tarifa = ventarifas.codigo;
	
				if v_moneda <> "" then
					v_precio_acabado = v_precio_acabado / f_cambio_moneda(v_moneda)
				end if
				
				if v_precio_acabado = 0 then
					v_precio = 0
				else
					v_precio = v_precio_acabado * (1 - v_valor_acabado/100)
				end if
			end if
					
				des_articulo = left (des_articulo, 30)	
					
				insert into venlintarifas
					(empresa, tarifa, fecha, articulo, calidad, precio, falta, montajeartcal, familia, formato, 
					activo, listar, usuario, descripcion, excepcion, tipo_linea)
					values (:codigo_empresa, "5", :v_fecha_tar_activa, :v_articulo, "1", :v_precio, :v_fecha_alta,
							:articulo_calidad, :v_familia, :v_formato, "S", "S", :v_usuario, :des_articulo, "N", "2");
							
				if SQLCA.SQLCode <> 0 then bien = 1						
		NEXT
	
		IF bien = 1 THEN
			rollback;
			MessageBox("Problemas en la transaccion", &
						  "No se pueden grabar la tarifa de valoración de stock", &
						  Exclamation!,Ok!,2)
		ELSE
			commit;
		END IF
	END IF
	
	destroy dw_proceso
end if

end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venlintarifas
integer x = 2121
integer y = 564
integer width = 562
end type

on cb_borrar::clicked;call wi_mvent_con_empresa`cb_borrar::clicked;dw_detalle.Retrieve(codigo_empresa,em_tarifa.text, DateTime(Date(String(sle_fecha.Text))))
end on

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venlintarifas
integer x = 443
integer y = 332
integer width = 279
integer taborder = 30
string facename = "System"
string mask = "XXXXXXXXXXXXXXXXXXXX"
end type

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_nombre_calidad.text=f_nombre_calidad_abr(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_calidad.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end on

event sle_valor::getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE CALIDADES"
		ue_datawindow = "dw_ayuda_calidades"
		ue_filtro     = ""
      isle_campo    = sle_valor
	   ue_campo    = sle_valor



   
        






end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venlintarifas
integer x = 2121
integer y = 660
integer width = 562
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venlintarifas
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venlintarifas
integer x = 5
integer y = 92
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venlintarifas
integer y = 4
integer width = 2702
end type

type st_nombre_tarifa from statictext within wi_mant_venlintarifas
integer x = 1038
integer y = 132
integer width = 1047
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type sle_fecha from u_em_campo within wi_mant_venlintarifas
integer x = 731
integer y = 132
integer width = 302
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "System"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

on getfocus;call u_em_campo::getfocus;isle_campo        = This
If sle_fecha.text = "00/00/00" Then
  em_tarifa.TriggerEvent("modificado")
END IF




end on

on modificado;call u_em_campo::modificado;Datetime fecha,fecha1
String   tarifa
fecha   = Datetime(Date(sle_fecha.text))
tarifa  = em_tarifa.text

  SELECT venmapatarifas.f_alta  
    INTO :fecha1  
    FROM venmapatarifas  
   WHERE ( venmapatarifas.empresa = :codigo_empresa ) AND  
         ( venmapatarifas.tarifa = :tarifa ) AND  
         ( venmapatarifas.fecha = :fecha )   ;
  IF SQLCA.SQLCODE =100   THEN
      MessageBox("Tarifa no definida en el mapa","No existe la tarifa a esa fecha ",Exclamation!, OK!,1)
      em_tarifa.TriggerEvent("modificado")
      sle_fecha.SetFocus()
      RETURN
  END IF

end on

type st_2 from statictext within wi_mant_venlintarifas
integer x = 160
integer y = 136
integer width = 256
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_tarifa from u_em_campo within wi_mant_venlintarifas
integer x = 443
integer y = 132
integer width = 279
integer taborder = 10
string facename = "System"
end type

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE TARIFAS"
 ue_datawindow = "dw_ayuda_ventarifas"
 ue_filtro     = ""
 isle_campo    = This
 ue_campo      = This
 
  sle_valor.text             = ""
  st_nombre_calidad.text     = ""
  em_articulo.text  = ""

 f_control()
 
 IF istr_parametros.i_nargumentos>1 THEN
	  sle_valor.text=istr_parametros.s_argumentos[5]	
     em_articulo.text=istr_parametros.s_argumentos[4]
     em_tarifa.text=istr_parametros.s_argumentos[2]
     sle_fecha.text= istr_parametros.s_argumentos[3]
     f_no_nulo(em_tarifa)
     st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
     f_no_nulo(em_tarifa)     
     st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
	  f_no_nulo(em_articulo.em_codigo)
     em_articulo.TriggerEvent("modificado")
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
     IF Trim(sle_valor.text)<>"" and Trim(sle_valor.text)<>"" THEN
          f_control()
          f_activar_campo(sle_valor) 
     END IF
END IF

   
        
end event

event modificado;call super::modificado;
 
st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(em_tarifa.text)<>"" Then  f_activar_campo(em_tarifa)
 em_tarifa.text=""
END IF


String tarifa,var_empresa,var_codigo
Datetime var_activa
tarifa =em_tarifa.text

SELECT ventarifas.empresa,ventarifas.codigo,ventarifas.activa,ventarifas.moneda
INTO  :var_empresa,:var_codigo,:var_activa,:var_moneda 
FROM   ventarifas  
WHERE (ventarifas.empresa = :codigo_empresa ) AND  
      (ventarifas.codigo  = :tarifa )   
ORDER BY  ventarifas.empresa ASC,ventarifas.codigo ASC;

//***
if var_moneda="1" then
	f_mascara_columna(dw_1,"precio","###,###,###,###.00")
	f_mascara_columna(dw_detalle,"precio","###,###,###,###.00")
else
	f_mascara_columna(dw_1,"precio",f_mascara_precios_moneda(var_moneda))
	f_mascara_columna(dw_detalle,"precio",f_mascara_precios_moneda(var_moneda))
end if
Date fecha
fecha = date(var_activa)
sle_fecha.text = String(fecha,"dd-mm-yy")

dw_fechas.Retrieve(codigo_empresa,em_tarifa.text)
IF istr_parametros.i_nargumentos<=1 Then
dw_detalle.Retrieve(codigo_empresa,em_tarifa.text, DateTime(Date(String(sle_fecha.Text))))
END IF



end event

type st_nombre_calidad from statictext within wi_mant_venlintarifas
integer x = 741
integer y = 332
integer width = 978
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "System"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_3 from statictext within wi_mant_venlintarifas
integer x = 142
integer y = 236
integer width = 274
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_fechas from datawindow within wi_mant_venlintarifas
integer x = 2117
integer y = 128
integer width = 562
integer height = 252
boolean bringtotop = true
string dataobject = "dw_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return
sle_fecha.text  = String(Date(This.GetItemDateTime(row,"fecha")))
f_control()
dw_detalle.Retrieve(codigo_empresa,em_tarifa.text, DateTime(Date(String(sle_fecha.Text))))
f_activar_campo(em_articulo.em_codigo)
end event

type em_articulo from u_em_campo_2 within wi_mant_venlintarifas
event destroy ( )
integer x = 443
integer y = 232
integer width = 1271
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on em_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;em_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,em_articulo.em_codigo.text)

IF Trim(em_articulo.em_campo.text)="" THEN 
 IF Trim(em_articulo.em_codigo.text)<>"" Then em_articulo.em_campo.SetFocus()
 em_articulo.em_campo.text=""
 em_articulo.em_codigo.text=""
END IF






end event

event busqueda;str_parametros param

IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return

param.s_titulo_ventana   =  ue_titulo
param.s_nom_datawindow   =  ue_datawindow
param.s_filtro           =  ue_filtro
param.b_empresa          =  valor_empresa
This.em_codigo.text      =  Trim(ue_valor)
This.em_campo.text       =  ""
f_buscar_largo(This.em_codigo,param)
This.TriggerEvent("modificado")
ue_valor_anterior = Trim(em_campo.text)
ue_campo.SetFocus()
ue_campo.SelectText(1,Len(ue_campo.Text))
end event

event getfocus;ue_titulo     = "Ayuda seleccion de articulos"
//ue_datawindow = "dw_ayuda_articulos"
ue_datawindow = "dw_ayuda_articulos_almcliartdesc"
ue_filtro     = ""

end event

type dw_detalle from datawindow within wi_mant_venlintarifas
integer x = 27
integer y = 776
integer width = 2656
integer height = 1568
integer taborder = 50
string dataobject = "dw_venlintarifas2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

ultima_fila_editada = row

em_articulo.em_codigo.text = dw_detalle.GetItemString(row,"venlintarifas_articulo")
em_articulo.em_campo.text = f_nombre_articulo(codigo_empresa,em_articulo.em_codigo.text)

em_articulo.em_codigo.TriggerEvent("modificado")
sle_valor.text  = dw_detalle.GetItemString(row,"calidad")
sle_valor.TriggerEvent("modificado")

f_activar_campo(sle_valor)
Parent.TriggerEvent("ue_recuperar")

end event

event retrieveend;if rowcount > 0 then
	this.setrow(ultima_fila_editada) 
	this.scrolltorow(ultima_fila_editada) 
end if
end event


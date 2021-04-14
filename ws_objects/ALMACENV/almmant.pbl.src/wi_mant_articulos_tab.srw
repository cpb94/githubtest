$PBExportHeader$wi_mant_articulos_tab.srw
forward
global type wi_mant_articulos_tab from wc_mantenimientos_tab
end type
type p_1 from picture within pagina_2
end type
type cb_1 from u_boton within pagina_3
end type
type cb_2 from u_boton within pagina_3
end type
type dw_pallets from datawindow within wi_mant_articulos_tab
end type
type dw_calidades from datawindow within wi_mant_articulos_tab
end type
type dw_cajas from datawindow within wi_mant_articulos_tab
end type
type dw_proceso from datawindow within wi_mant_articulos_tab
end type
type st_4 from statictext within wi_mant_articulos_tab
end type
type pb_calculadora from u_calculadora within wi_mant_articulos_tab
end type
end forward

global type wi_mant_articulos_tab from wc_mantenimientos_tab
integer width = 3493
integer height = 2164
dw_pallets dw_pallets
dw_calidades dw_calidades
dw_cajas dw_cajas
dw_proceso dw_proceso
st_4 st_4
pb_calculadora pb_calculadora
end type
global wi_mant_articulos_tab wi_mant_articulos_tab

type variables
datawindow dw_1
String familia,formato,modelo,subfamilia,subformato
u_pipe i_upipe


end variables

forward prototypes
public subroutine f_borrar_cajas ()
public subroutine f_borrar_calidades ()
public subroutine grabar_calidades (string codemp, string codformato, string codarticulo)
end prototypes

public subroutine f_borrar_cajas ();Integer x1,registros
String var_empresa,var_articulo,var_caja
registros = dw_cajas.RowCount()
IF registros=0 Then return
For x1= 1 To registros
   var_empresa   = dw_cajas.GetItemString(x1,"empresa")
   var_articulo  = dw_cajas.GetItemString(x1,"articulo")
   var_caja   = dw_cajas.GetItemString(x1,"caja")
   DELETE FROM almartcajas  
   WHERE ( almartcajas.empresa = :var_empresa ) AND  
         ( almartcajas.articulo = :var_articulo ) AND  
         ( almartcajas.caja = :var_caja )USING SQLCA;


Next
end subroutine

public subroutine f_borrar_calidades ();Integer x1,registros
String var_empresa,var_articulo,var_calidad
registros = dw_calidades.RowCount()
IF registros=0 Then return
For x1= 1 To registros
   var_empresa   = dw_calidades.GetItemString(x1,"empresa")
   var_articulo  = dw_calidades.GetItemString(x1,"articulo")
   var_calidad   = dw_calidades.GetItemString(x1,"calidad")
   DELETE FROM almartcal  
   WHERE ( almartcal.empresa = :var_empresa ) AND  
         ( almartcal.articulo = :var_articulo ) AND  
         ( almartcal.calidad = :var_calidad )USING SQLCA;


Next
end subroutine

public subroutine grabar_calidades (string codemp, string codformato, string codarticulo);// Graba el mapa de calidades por formato en el mapa de calidades por articulo
integer li_opcion,bien,registros
String cal_empresa,cal_formato,cal_calidad,art_empresa,art_calidad
decimal{4}  cal_precioventa,art_precio
datetime    cal_fechaalta,art_fecha_alta
string      art_articulo,fin
integer cont

dw_proceso.SetTransObject(SQLCA)

registros=dw_proceso.Retrieve(codigo_empresa,codformato)

IF registros=0 Then Return
FOR cont= 1 To registros
 cal_empresa     = dw_proceso.GetItemString(cont,"empresa")
 cal_formato     = dw_proceso.GetItemString(cont,"formato")
 cal_calidad     = dw_proceso.GetItemString(cont,"calidad")
 cal_precioventa = dw_proceso.GetItemDecimal(cont,"precioventa")
 cal_fechaalta   = Datetime(today(),now())

SELECT almartcal.empresa,almartcal.articulo,almartcal.calidad,   
       almartcal.precio,almartcal.fecha_alta
INTO   :art_empresa,:art_articulo,:art_calidad,:art_precio,:art_fecha_alta  
FROM   almartcal  
WHERE (almartcal.empresa  = :cal_empresa ) AND  
      (almartcal.articulo = :codarticulo ) AND  
      (almartcal.calidad  = :cal_calidad )   
ORDER BY almartcal.empresa ASC,almartcal.articulo ASC,
         almartcal.calidad ASC;
   IF SQLCA.SQLCode=0 THEN
        li_opcion = MessageBox("Existen Calidades Por Articulo", &
			                      "Refrescar la Calidad Según Formato", &
               						Question!, YesNo!, 2)
         IF li_opcion=1 THEN
            DELETE FROM almartcal  
            WHERE (almartcal.empresa  = :codemp ) AND  
            (almartcal.articulo = :codarticulo ) AND  
            (almartcal.calidad  = :cal_calidad ) 
            USING SQLCA;
           IF SQLCA.SQLCode<>0 THEN     bien=1
         END IF
     ELSE
        li_opcion=1
     END IF
    If li_opcion=1 THEN
     INSERT INTO almartcal  
         ( empresa,articulo,calidad,precio,fecha_alta )  
  VALUES ( :cal_empresa,:codarticulo,:cal_calidad,   
           :cal_precioventa,:cal_fechaalta ) 
           USING SQLCA;
           IF SQLCA.SQLCode<>0 THEN  bien=1
END IF                                     
NEXT

IF bien=1 THEN
   ROLLBACK USING SQLCA;
   MessageBox("Problemas en la transaccion", &
    			  "No se puede Grabar El mapa de Calidades", &
					Exclamation!, Ok!, 2)
ELSE
   COMMIT USING SQLCA;
END IF

end subroutine

on wi_mant_articulos_tab.create
int iCurrent
call super::create
this.dw_pallets=create dw_pallets
this.dw_calidades=create dw_calidades
this.dw_cajas=create dw_cajas
this.dw_proceso=create dw_proceso
this.st_4=create st_4
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pallets
this.Control[iCurrent+2]=this.dw_calidades
this.Control[iCurrent+3]=this.dw_cajas
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.pb_calculadora
end on

on wi_mant_articulos_tab.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_pallets)
destroy(this.dw_calidades)
destroy(this.dw_cajas)
destroy(this.dw_proceso)
destroy(this.st_4)
destroy(this.pb_calculadora)
end on

event open;call super::open;dw_1=apartados.pagina_1.dw_pagina1

istr_parametros.s_titulo_ventana = "Mantenimiento de Articulos"
istr_parametros.s_listado        = "report_articulos"
This.title  =  istr_parametros.s_titulo_ventana

dw_proceso.SetTransObject(SQLCA)

dw_1.settransobject(sqlca)
dw_1.sharedata(apartados.pagina_4.dw_pagina4)
dw_calidades.SetTransObject(SQLCA)
dw_pallets.SetTransObject(SQLCA)
dw_cajas.SetTransObject(SQLCA)


IF istr_parametros.i_nargumentos>1 THEN
    sle_valor.text=istr_parametros.s_argumentos[2]
    f_no_nulo(sle_valor)
    This.TriggerEvent("ue_recuperar")
END IF

f_mascara_columna(dw_1,"pesopieza","###.000")
f_mascara_columna(dw_1,"piezascaja","###0")
f_mascara_columna(dw_1,"pesocaja","###.00")
f_mascara_columna(dw_1,"metroslcaja","###.00")
f_mascara_columna(dw_1,"metroscaja","###.00")

cb_borrar.Enabled = false




end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
st_4.visible = TRUE

end event

event ue_borra_fila;call super::ue_borra_fila;f_borrar_calidades()
f_borrar_cajas()
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
st_4.visible = FALSE

end event

event ue_f6;IF pb_calculadora.visible = FALSE Then Return
pb_calculadora.TriggerEvent(Clicked!)
end event

event ue_inserta_fila;call super::ue_inserta_fila;Dec{2} var_precio_coste,var_piezas_caja,var_metros,var_metrosl
Dec{3} var_peso_envase,var_peso

String  var_empresa,var_formato,tono,calibre
if insercion='S' then
   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"activo","S")
   dw_1.SetItem(dw_1.GetRow(),"fecha_alta",today())
/*   familia    = String(Integer(Mid(sle_valor.text,1,2)))
	if isnumber(Mid(sle_valor.text,3,2)) then
		subfamilia = String(Integer(Mid(sle_valor.text,3,2)))
	else
		subfamilia=Mid(sle_valor.text,3,2)
	end if
   formato    = String(Integer(Mid(sle_valor.text,5,2)))
	subformato = String(Integer(Mid(sle_valor.text,7,2)))
	modelo     = String(Integer(Mid(sle_valor.text,9,5)))*/
	Select tono,calibre Into :tono,:calibre From familias
	Where empresa = :codigo_empresa
	And   codigo  = :familia;
   dw_1.setitem(dw_1.getrow(),"tono",tono)
   dw_1.setitem(dw_1.getrow(),"calibre",calibre)

SELECT    formatos.empresa,formatos.codigo,formatos.preciocoste,formatos.pesopieza  ,formatos.piezascaja   ,formatos.pesoenvase,formatos.metroscaja,formatos.metroslcaja
INTO      :var_empresa,:var_formato,:var_precio_coste ,:var_peso,:var_piezas_caja,:var_peso_envase,:var_metros,:var_metrosl
FROM      formatos  
WHERE    (formatos.empresa = :codigo_empresa )
AND      (formatos.codigo = :formato )   
ORDER BY formatos.empresa ASC,formatos.codigo ASC;


   dw_1.setitem(dw_1.getrow(),"precio_coste",var_precio_coste)
   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
   dw_1.setitem(dw_1.getrow(),"familia",familia)
   dw_1.setitem(dw_1.getrow(),"formato",formato)
   dw_1.setitem(dw_1.getrow(),"subfamilia",subfamilia)
   dw_1.setitem(dw_1.getrow(),"subformato",subformato)	
	dw_1.setitem(dw_1.getrow(),"modelo",modelo)
	dw_1.setitem(dw_1.getrow(),"pesopieza",var_peso)
	dw_1.setitem(dw_1.getrow(),"pesoenvase",var_peso_envase)
	dw_1.setitem(dw_1.getrow(),"metroscaja",var_metros)
	dw_1.setitem(dw_1.getrow(),"metroslcaja",var_metrosl)
	dw_1.setitem(dw_1.getrow(),"piezascaja",var_piezas_caja)
   dw_1.setitem(dw_1.getrow(),"decorado",f_decorado_familia(codigo_empresa,familia)) 
   dw_1.setitem(dw_1.getrow(),"sector",f_sector_familia(codigo_empresa,familia)) 
	dw_1.setitem(dw_1.getrow(),"compras","N") 

   grabar_calidades(codigo_empresa,formato,sle_valor.text)

   dw_calidades.Retrieve(codigo_empresa,sle_valor.text)
// dw_pallets.Retrieve(codigo_empresa,formato,sle_valor.text)
//	dw_cajas.Retrieve(codigo_empresa,sle_valor.text)

   



end if

long i
for i=1 to apartados.pagina_3.dw_pagina3.rowcount()
	apartados.pagina_3.dw_pagina3.setitem(1,"empresa",codigo_empresa)
	apartados.pagina_3.dw_pagina3.setitem(1,"articulo",sle_valor.text)
next
end event

event ue_recuperar;integer registros,longitudes
String codigo

// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud    =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]
tabla[1]         =  "articulos"

registros=dw_1.Retrieve(codigo_empresa,sle_valor.Text)

//Refrescamos las calidades por articulo.
dw_pallets.visible   = TRUE
dw_calidades.visible = TRUE
dw_cajas.visible     = TRUE

// If registros=0 THEN
//    codigo= Mid(sle_valor.text,3,3)
//Else
//   codigo=dw_1.getitemString(dw_1.getrow(),"formato")
//End if

dw_pallets.Retrieve(codigo_empresa,sle_valor.text)
dw_calidades.Retrieve(codigo_empresa,sle_valor.text)
dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
dw_pag2.retrieve(codigo_empresa,sle_valor.text)
apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,sle_valor.Text)
// Control codigo articulo
   
//	Integer bien
//   String valor
//   bien=0
//
//   longitudes=len(Trim(sle_valor.text))
//   IF longitudes<>13 THEN  bien=1
//	
//   familia = String(Integer(Mid(sle_valor.text,1,2)))
//   valor=f_nombre_familia(codigo_empresa,familia)
//   If Trim(valor)="" THEN  bien=1
//
//	if isnumber(Mid(sle_valor.text,3,2)) then
//	   subfamilia = String(Integer(Mid(sle_valor.text,3,2)))
//	else
//		subfamilia=Mid(sle_valor.text,3,2)
//	end if
//   valor=f_nombre_subfamilia(codigo_empresa,subfamilia)
//   If Trim(valor)="" THEN  bien=1	
//	
//   formato = String(Integer(Mid(sle_valor.text,5,2)))
//   valor=f_nombre_formato(codigo_empresa,formato)
//	If Trim(valor)="" THEN  bien=1	
//	
//   subformato = String(Integer(Mid(sle_valor.text,7,2)))
//   valor=f_nombre_subformato(codigo_empresa,subformato)
//   If Trim(valor)="" THEN  bien=1	
//	
//  
//   if bien=1 then
//		  f_activar_campo(sle_valor)
//		  return
//	End if	  
   
	
	i_upipe = CREATE u_pipe
	
	CALL Super::ue_recuperar
	

end event

event ue_valores;call super::ue_valores;pag1 = true
pag2 = true
pag3 = true
pag4 = true

pag_act1 = TRUE
pag_act3 = TRUE

prin_pag1 = true
prin_pag2 = false
prin_pag3 = true
//prin_pag4 = true
end event

event ue_pase_valores;call super::ue_pase_valores;dw_pag1.object.imagen[1]=dw_pag2.object.imagen[1]
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within wi_mant_articulos_tab
integer x = 2514
integer y = 168
integer taborder = 40
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within wi_mant_articulos_tab
boolean visible = false
integer taborder = 80
boolean enabled = false
end type

event cb_borrar::clicked;call super::clicked;//Dec{0} cont
//Integer resp
//
//// antes de borrar el artículo hacemos una comprobación de la 
//// integridad referencial
//
//// almlinubica
//SELECT count(*)
//  INTO :cont
//  FROM almlinubica 
// WHERE almlinubica.empresa  = :codigo_empresa
//   AND almlinubica.articulo = :sle_valor.text;
//	
//if IsNull(cont) then cont = 0
//
//if cont > 0 then
//	resp = MessageBox("Borrado de un artículo","¡¡El artículo tiene stock en el almacén!! ¿Está seguro que desea dar de baja el artículo?",StopSign!,YesNo!,2)
//	if resp = 2 then return
//end if
//
//// venlifac
//SELECT count(*)
//  INTO :cont
//  FROM venlifac 
// WHERE venlifac.empresa  = :codigo_empresa
//   AND venlifac.articulo = :sle_valor.text;
//	
//if IsNull(cont) then cont = 0
//
//if cont > 0 then
//	resp = MessageBox("Borrado de un artículo","¡¡El artículo aparece en algunas líneas de factura!! ¿Está seguro que desea dar de baja el artículo?",StopSign!,YesNo!,2)
//	if resp = 2 then return
//end if
//
//// almmovhis
//SELECT count(*)
//  INTO :cont
//  FROM almmovhis 
// WHERE almmovhis.empresa  = :codigo_empresa
//   AND almmovhis.articulo = :sle_valor.text;
//	
//if IsNull(cont) then cont = 0
//
//if cont > 0 then
//	resp = MessageBox("Borrado de un artículo","¡¡El artículo tiene movimientos de stock!! ¿Está seguro que desea dar de baja el artículo?",StopSign!,YesNo!,2)
//	if resp = 2 then return
//end if
//
//Call super:: clicked
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within wi_mant_articulos_tab
integer x = 2066
integer y = 168
integer taborder = 90
end type

event cb_insertar::clicked;string cliente
if dw_1.rowcount() > 0 then
	cliente = dw_1.object.cliente[dw_1.getrow()]
	if not isnull(cliente) then
		if trim(cliente) = "" then
			setnull(cliente)
		else
			cliente = trim(cliente)
		end if
		dw_1.object.cliente[dw_1.getrow()] = cliente
		dw_1.accepttext()
	end if
end if

CALL Super::Clicked
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within wi_mant_articulos_tab
integer taborder = 100
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within wi_mant_articulos_tab
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within wi_mant_articulos_tab
end type

event sle_valor::getfocus;ue_titulo      = "AYUDA SELECCION DE ARTICULOS"
ue_datawindow  = "dw_ayuda_articulos_almcliartdesc"
ue_filtro      = ""
isle_campo     = This

dw_calidades.Retrieve(codigo_empresa,sle_valor.text)
dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
dw_pallets.Retrieve(codigo_empresa,sle_valor.text)


end event

event sle_valor::busqueda;str_parametros param
IF IsNull(ue_datawindow) or Trim(ue_datawindow)="" Then Return
param.s_titulo_ayuda    = ue_titulo
param.s_nom_datawindow  = ue_datawindow
param.s_filtro          = ue_filtro
param.b_empresa         = valor_empresa
This.text = ue_valor
f_buscar_largo(This,param)
This.TriggerEvent("modificado")
ue_ante_valor = This.text
This.SelectText(1,Len(This.Text))
end event

type st_1 from wc_mantenimientos_tab`st_1 within wi_mant_articulos_tab
integer width = 256
string text = "Articulo:"
end type

type apartados from wc_mantenimientos_tab`apartados within wi_mant_articulos_tab
integer x = 23
integer y = 272
integer width = 3305
integer height = 1368
end type

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 3269
integer height = 1240
string text = "Articulo"
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer width = 3232
integer height = 1236
string dataobject = "dw_articulos"
end type

event dw_pagina1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE f_objeto_datawindow(dw_1)
CASE 'pb_unidad'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"unidad")
   OpenWithParm(wi_mant_unidades,lstr_param) 

CASE 'pb_proveedor'
	lstr_param.s_argumentos[2]="P"
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"proveedor")
   OpenWithParm(wi_mant_clipro,lstr_param) 
CASE 'pb_cliente'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"cliente")
 	OpenWithParm(wi_mant_clientes2,lstr_param)  
CASE 'pb_uso'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"uso")
 	OpenWithParm(wi_mant_almusos,lstr_param)  	 
CASE 'pb_estilo'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"estilo")
 	OpenWithParm(wi_mant_almestilos,lstr_param)  	 	 
CASE 'pb_coleccion'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"coleccion")
 	OpenWithParm(wi_mant_almcolecciones,lstr_param)  	 	 	 
CASE 'pb_color'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"color")
 	OpenWithParm(wi_mant_almcolores,lstr_param)  	 	 	 	 
CASE 'pb_familia'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"familia")
 	OpenWithParm(wi_mant_familias,lstr_param)  	 	 	 	 
CASE 'pb_subfamilia'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"subfamilia")
 	OpenWithParm(wi_mant_subfamilias,lstr_param)  	 	 	 	 
CASE 'pb_formato'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"formato")
 	OpenWithParm(wi_mant_formatos,lstr_param)  	 	 	 	 
CASE 'pb_subformato'
	lstr_param.i_nargumentos   = 2
 	lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"subformato")
 	OpenWithParm(wi_mant_subformatos,lstr_param)  	 	 	 	 	 
CASE 'pb_cuenta'
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"empresa")
   lstr_param.s_argumentos[4]=GetItemString(This.GetRow(),"cuenta_contable")
   OpenWithParm(wi_mant_contaplan,lstr_param) 	
END CHOOSE
end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;string uni_est,uni
uni     = This.GetItemString(row,"unidad")
uni_est = This.GetItemString(row,"unidad_est")
if isnull(uni_est) then uni_est = ""
 
if uni <>"" and uni_est="" then
	this.Setitem(row,"unidad_est",uni)
End if

end event

event dw_pagina1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "unidad"
		valor_empresa = FALSE
      bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDADES "
 		bus_datawindow = "dw_ayuda_unidades"
   CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores_sector"
  	CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"		 
	CASE "cuenta_contable"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio =" + String(f_ejercicio_activo(codigo_empresa)) 
	CASE "empleado"
      bus_titulo     = "VENTANA SELECCION DE EMPLEADOS"
     	bus_datawindow = "dw_ayuda_empleados"
      bus_filtro     = "" 
	CASE "uso"
      bus_titulo     = "VENTANA SELECCION DE USOS"
     	bus_datawindow = "dw_ayuda_almusos"
      bus_filtro     = "" 		
	CASE "estilo"
      bus_titulo     = "VENTANA SELECCION DE ESTILOS"
     	bus_datawindow = "dw_ayuda_almestilos"
      bus_filtro     = "" 								
	CASE "coleccion"
      bus_titulo     = "VENTANA SELECCION DE COLECCIONES"
     	bus_datawindow = "dw_ayuda_almcolecciones"
      bus_filtro     = "" 								
	CASE "color"
      bus_titulo     = "VENTANA SELECCION DE COLOR"
     	bus_datawindow = "dw_ayuda_almcolores"
      bus_filtro     = "" 										
	CASE "familia"
      bus_titulo     = "VENTANA SELECCION DE FAMILIAS"
     	bus_datawindow = "dw_ayuda_familias"
      bus_filtro     = "" 										
	CASE "subfamilia"
      bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS"
     	bus_datawindow = "dw_ayuda_subfamilias"
      bus_filtro     = "" 										
	CASE "formato"
      bus_titulo     = "VENTANA SELECCION DE FORMATOS"
     	bus_datawindow = "dw_ayuda_formatos"
      bus_filtro     = "" 										
	CASE "subformato"
      bus_titulo     = "VENTANA SELECCION DE SUBFORMATOS"
     	bus_datawindow = "dw_ayuda_subformatos"
      bus_filtro     = "" 												
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 

end event

event dw_pagina1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "unidad"
		valor_empresa = FALSE
      bus_titulo     = "VENTANA SELECCION DE TIPO DE UNIDAD "
 		bus_datawindow = "dw_ayuda_unidades"
	   valor_empresa = FALSE
   CASE "proveedor"
      bus_titulo     = "VENTANA SELECCION DE PROVEEDORES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_proveedores_sector"
  	CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"		
   CASE "cuenta_contable"
      bus_titulo     = "VENTANA SELECCION DE CUENTAS"
     	bus_datawindow = "dw_ayuda_contaplan"
      bus_filtro     = "ejercicio ='" + String(f_ejercicio_activo(codigo_empresa)) +"'"
	CASE "empleado"
      bus_titulo     = "VENTANA SELECCION DE EMPLEADOS"
     	bus_datawindow = "dw_ayuda_empleados"
      bus_filtro     = "" 
	CASE "uso"
      bus_titulo     = "VENTANA SELECCION DE USOS"
     	bus_datawindow = "dw_ayuda_almusos"
      bus_filtro     = "" 				
	CASE "estilo"
      bus_titulo     = "VENTANA SELECCION DE ESTILOS"
     	bus_datawindow = "dw_ayuda_almestilos"
      bus_filtro     = "" 						
	CASE "coleccion"
      bus_titulo     = "VENTANA SELECCION DE COLECCIONES"
     	bus_datawindow = "dw_ayuda_almcolecciones"
      bus_filtro     = "" 								
	CASE "color"
      bus_titulo     = "VENTANA SELECCION DE COLOR"
     	bus_datawindow = "dw_ayuda_almcolores"
      bus_filtro     = "" 												
	CASE "familia"
      bus_titulo     = "VENTANA SELECCION DE FAMILIAS"
     	bus_datawindow = "dw_ayuda_familias"
      bus_filtro     = "" 										
	CASE "subfamilia"
      bus_titulo     = "VENTANA SELECCION DE SUBFAMILIAS"
     	bus_datawindow = "dw_ayuda_subfamilias"
      bus_filtro     = "" 										
	CASE "formato"
      bus_titulo     = "VENTANA SELECCION DE FORMATOS"
     	bus_datawindow = "dw_ayuda_formatos"
      bus_filtro     = "" 										
	CASE "subformato"
      bus_titulo     = "VENTANA SELECCION DE SUBFORMATOS"
     	bus_datawindow = "dw_ayuda_subformatos"
      bus_filtro     = "" 														
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina1::valores_numericos;f_valores_numericos(dw_1,"unidad")
f_valores_numericos(dw_1,"proveedor")
f_valores_numericos(dw_1,"cuenta_contable")
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 3269
integer height = 1240
string text = "Imagen"
p_1 p_1
end type

on pagina_2.create
this.p_1=create p_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on pagina_2.destroy
call super::destroy
destroy(this.p_1)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 64
integer y = 40
integer width = 2336
integer height = 88
string dataobject = "dw_articulos_imagen"
end type

event dw_pagina2::itemchanged;if row=0 then return
if rowcount()=0 then return

p_1.picturename=object.imagen[getrow()]
end event

event dw_pagina2::itemfocuschanged;call super::itemfocuschanged;if row=0 then return
if rowcount()=0 then return

p_1.picturename=object.imagen[getrow()]
end event

event dw_pagina2::rowfocuschanged;call super::rowfocuschanged;if currentrow=0 then return
if rowcount()=0 then return

p_1.picturename=object.imagen[getrow()]
end event

event dw_pagina2::retrieveend;if getrow()=0 then return

p_1.picturename=object.imagen[getrow()]
end event

event dw_pagina2::key;call super::key;if rowcount()=0 then return

accepttext()
p_1.picturename=object.imagen[getrow()]
end event

event dw_pagina2::clicked;call super::clicked;int valor
string fichero,directorio
if row=0 then return
if rowcount()=0 then return

if dwo.name='pb_fichero' then
	valor = GetFileOpenName("Abrir fichero", +&
 directorio, fichero, "BMP", &
	+ "BMP (*.BMP),*.BMP,RLE (*.RLE),*.RLE,WMF (*.WMF),*.WMF")

	IF valor= 1 THEN 
		object.imagen[1]=directorio
		p_1.picturename=directorio
	end if
end if
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 3269
integer height = 1240
string text = "Idiomas"
cb_1 cb_1
cb_2 cb_2
end type

on pagina_3.create
this.cb_1=create cb_1
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on pagina_3.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer width = 2171
integer height = 1068
string dataobject = "dw_almcliartdesc"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina3::ue_valores;call super::ue_valores;ue_marca_linea=true
end event

event dw_pagina3::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"		 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 

end event

event dw_pagina3::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo     = "VENTANA SELECCION DE CLIENTES"		 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 

end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 3269
integer height = 1240
string text = "Datos Producción"
end type

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer width = 2807
integer height = 1140
string dataobject = "dw_articulos_produccion"
end type

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 3269
integer height = 1240
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
end type

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 3269
integer height = 1240
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
end type

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 3269
integer height = 1240
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
end type

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 3269
integer height = 1240
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
end type

type p_1 from picture within pagina_2
integer x = 41
integer y = 140
integer width = 2770
integer height = 992
boolean bringtotop = true
boolean originalsize = true
boolean border = true
boolean focusrectangle = false
end type

type cb_1 from u_boton within pagina_3
integer x = 2345
integer y = 48
integer height = 92
integer taborder = 11
boolean bringtotop = true
string text = "Insertar"
end type

event clicked;wc_index = 3

apartados.TriggerEvent("pulsar_datawindow")

if dw_pagina3.rowcount()<>0 then
	long donde
	donde=dw_pagina3.insertrow(0)
	dw_pagina3.setitem(donde,"empresa",codigo_empresa)
	dw_pagina3.setitem(donde,"articulo",sle_valor.text)
	dw_pagina3.setfocus()
	dw_pagina3.setrow(donde)
	dw_pagina3.setcolumn("cliente")
end if

end event

type cb_2 from u_boton within pagina_3
integer x = 2345
integer y = 176
integer height = 92
integer taborder = 11
boolean bringtotop = true
string text = "Borrar"
end type

event clicked;wc_index = 3
apartados.TriggerEvent("pulsar_datawindow")

dw_pagina3.deleterow(dw_pagina3.getrow())
end event

type dw_pallets from datawindow within wi_mant_articulos_tab
boolean visible = false
integer x = 1723
integer y = 1612
integer width = 1134
integer height = 280
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_palarticulos"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto,codigo
str_parametros lstr_param

codigo=dw_1.getitemString(dw_1.getrow(),"codigo")

CHOOSE CASE f_objeto_datawindow(This)
   CASE 'pb_carpeta'
			lstr_param.s_titulo_ventana = "Mantenimiento de Pallets por Artículo y Caja"
			lstr_param.s_argumentos[2]  = string(codigo)
	      lstr_param.i_nargumentos    = 2
			OpenWithParm(wi_mant_palarticulo, lstr_param)
			dw_pallets.Retrieve(codigo_empresa,codigo,sle_valor.text)
END CHOOSE

end event

event doubleclicked;//if row=0 then Return
//
//String codpallet,articulo,clase
//codpallet = dw_pallets.GetItemString(dw_pallets.GetRow(),"codigo")
//articulo  = sle_valor.text
//integer bien=0,cuantos
//
//// Verifica si esta el tipo de pallet seleccionado
//
//  SELECT almartpallet.pallet  
//    INTO :codpallet
//    FROM almartpallet  
//   WHERE ( almartpallet.empresa  = :codigo_empresa ) AND  
//	      ( almartpallet.articulo = :articulo       ) AND  
//         ( almartpallet.pallet   = :codpallet      );
//
//
//IF SQLCA.SQLCode = 0 THEN
// 		DELETE FROM almartpallet
//      WHERE ( almartpallet.empresa  = :codigo_empresa ) AND  
//	         ( almartpallet.articulo = :articulo       ) AND  
//            ( almartpallet.pallet   = :codpallet      ) USING SQLCA;
//				IF SQLCA.SQLCode<>0 THEN  bien=1
//				IF bien=1 THEN
//						ROLLBACK USING SQLCA;
//						MessageBox("Problemas en la transaccion", &
//									  "No se puede Grabar El tipo de pallet", &
//										Exclamation!, Ok!, 2)
//					 ELSE
//						COMMIT USING SQLCA;
//			   END IF
//
//  ELSE
//	   // verifica si existe alguna linea al mismo tipo de pallet
//		clase = f_clase_pallets(codigo_empresa,codpallet)
//		
//		select count(*)
//		into :cuantos
//		from almartpallet
//		Where almartpallet.empresa       = :codigo_empresa
//		  and almartpallet.articulo      = :articulo
//		  and almartpallet.clase_pallet  = :clase;
//      
//		IF cuantos<> 0 THEN
//			   MessageBox("Problemas en la selección", &
//    			  "No se pueden grabar 2 del mismo tipo de pallet", &
//					Exclamation!, Ok!, 2)
//
// 		 else
//			INSERT INTO almartpallet
//					 ( empresa,articulo,pallet,clase_pallet)
//			VALUES ( :codigo_empresa,:articulo,:codpallet,:clase)
//					 using SQLCA;
//					 IF SQLCA.SQLCode<>0 THEN  bien=1
//					 
//					 IF bien=1 THEN
//							ROLLBACK USING SQLCA;
//							MessageBox("Problemas en la transaccion", &
//										  "No se puede Grabar El tipo de pallet", &
//											Exclamation!, Ok!, 2)
//						ELSE
//							COMMIT USING SQLCA;
//                END IF
//
//		End if
//End if
//	
//
//
//dw_pallets.Retrieve(codigo_empresa,sle_valor.text)
end event

type dw_calidades from datawindow within wi_mant_articulos_tab
boolean visible = false
integer x = 14
integer y = 1612
integer width = 768
integer height = 280
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_articuloscal"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

CHOOSE CASE f_objeto_datawindow(This)

   CASE 'pb_carpeta'

			lstr_param.s_titulo_ventana = "Mantenimiento de Calidades por Articulo"
			lstr_param.s_argumentos[2]  = sle_valor.Text
         lstr_param.i_nargumentos    = 2
         OpenWithParm(wi_mant_almartcal, lstr_param)
   		dw_calidades.Retrieve(codigo_empresa,sle_valor.Text)
END CHOOSE

end event

type dw_cajas from datawindow within wi_mant_articulos_tab
boolean visible = false
integer x = 791
integer y = 1612
integer width = 933
integer height = 228
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_articuloscaja"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto
str_parametros lstr_param

CHOOSE CASE f_objeto_datawindow(This)

   CASE 'pb_carpeta'

			lstr_param.s_titulo_ventana = "Mantenimiento de Cajas por Artículo"
			lstr_param.s_argumentos[2]  = sle_valor.text
         lstr_param.i_nargumentos    = 2
         OpenWithParm(wi_mant_articulocaja, lstr_param)
   		dw_cajas.Retrieve(codigo_empresa,sle_valor.text)
END CHOOSE

end event

type dw_proceso from datawindow within wi_mant_articulos_tab
boolean visible = false
integer x = 5
integer y = 8
integer width = 398
integer height = 148
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_calformato"
boolean livescroll = true
end type

type st_4 from statictext within wi_mant_articulos_tab
integer x = 869
integer y = 140
integer width = 114
integer height = 40
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "F6"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_calculadora from u_calculadora within wi_mant_articulos_tab
integer x = 869
integer y = 180
integer width = 114
integer height = 100
integer taborder = 20
boolean originalsize = false
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros

Select count(*) 
Into :registros 
From articulos
where empresa = :codigo_empresa;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,codigo)+1) 
   Into   :registros
   From   articulos
	where empresa = :codigo_empresa;
	sle_valor.text=string(registros)
END IF
dw_1.TriggerEvent("Clicked")
end event


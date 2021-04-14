$PBExportHeader$w_preparacion_pedidos_promocion.srw
forward
global type w_preparacion_pedidos_promocion from w_int_con_empresa
end type
type st_conpromped2 from statictext within w_preparacion_pedidos_promocion
end type
type uo_cliente from u_em_campo_2 within w_preparacion_pedidos_promocion
end type
type pb_1 from upb_salir within w_preparacion_pedidos_promocion
end type
type pb_imprimir from upb_imprimir within w_preparacion_pedidos_promocion
end type
type dw_listado from datawindow within w_preparacion_pedidos_promocion
end type
type uo_manejo from u_manejo_datawindow within w_preparacion_pedidos_promocion
end type
type ddlb_1 from dropdownlistbox within w_preparacion_pedidos_promocion
end type
type ddlb_opcion from dropdownlistbox within w_preparacion_pedidos_promocion
end type
type dw_ubicaciones from datawindow within w_preparacion_pedidos_promocion
end type
type dw_detalle from u_datawindow_consultas within w_preparacion_pedidos_promocion
end type
type dw_pedidos from datawindow within w_preparacion_pedidos_promocion
end type
type dw_albaranes from datawindow within w_preparacion_pedidos_promocion
end type
type st_disponible from statictext within w_preparacion_pedidos_promocion
end type
end forward

global type w_preparacion_pedidos_promocion from w_int_con_empresa
integer width = 2935
integer height = 1680
st_conpromped2 st_conpromped2
uo_cliente uo_cliente
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
ddlb_1 ddlb_1
ddlb_opcion ddlb_opcion
dw_ubicaciones dw_ubicaciones
dw_detalle dw_detalle
dw_pedidos dw_pedidos
dw_albaranes dw_albaranes
st_disponible st_disponible
end type
global w_preparacion_pedidos_promocion w_preparacion_pedidos_promocion

type variables
Dec      anyo,pedido,linea,calibre,orden,cantidad,disponible
String   cliente,tipo_cli,tipo,tipo_pallet,articulo,calidad,expositor,situacion,panel,ubicacion,ser,sal,caja,tono

end variables

forward prototypes
public subroutine f_control ()
public function boolean f_cargar_lineas ()
public function boolean f_cargar_pedido ()
public subroutine f_activar_campos (boolean bool)
public subroutine f_ubicacion (integer rg)
public subroutine f_ubicacion_endamado (integer rg)
public subroutine f_salida_almacen_todo ()
public subroutine f_salida_almacen (decimal arg_reg)
public function boolean f_preparar_linea (decimal reg)
public subroutine f_cargar ()
public function boolean f_asignar_ubicaciones ()
public function boolean f_cargar_detalle ()
public function boolean f_orden_endamados ()
end prototypes

public subroutine f_control ();String filtro
dw_pedidos.SetFilter("")
dw_pedidos.Filter()
tipo_cli= "N"
if ddlb_1.text="Si" then tipo_cli="S"
IF Trim(uo_cliente.em_codigo.text) <> "" Then
filtro = " tipo_cliente = '" + tipo_cli+"' and  cliente = '" +uo_cliente.em_codigo.text + "' and "
END IF
CHOOSE CASE ddlb_opcion.text
	CASE "Panel de Mano"
		filtro = filtro + " tipo='1'"
  	CASE "Expositor"
		filtro = filtro + "  tipo='2'"
END CHOOSE
dw_pedidos.Setfilter(filtro)
dw_pedidos.filter()
dw_pedidos.Retrieve(codigo_empresa,"C")
end subroutine

public function boolean f_cargar_lineas ();Int      bien,reg,reg1,numero
Select Max(numero_orden) Into :orden From prompreparacionped
Where  empresa = :codigo_empresa;
IF IsNull(orden) Then orden = 0


bien = 0 
 SELECT promped.cliente,promped.expositor,promped.tipo,
        promped.tipo_cliente
    INTO :cliente,:expositor,:tipo,:tipo_cli
    FROM promped  
   WHERE promped.empresa = :codigo_empresa 
	AND   promped.anyo   = :anyo 
	AND   promped.pedido = :pedido ;

		Select Count(*) Into :numero From prompreparacionped
		Where  prompreparacionped.empresa = :codigo_empresa
		and    prompreparacionped.anyo    = :anyo
		and    prompreparacionped.pedido  = :pedido
		and    prompreparacionped.situacion  = "P";
				IF IsNull(numero) Then numero = 0
		IF numero = 0 Then
			Delete From  prompreparacionped
			Where  prompreparacionped.empresa = :codigo_empresa
			and    prompreparacionped.anyo    = :anyo
			and    prompreparacionped.pedido  = :pedido;
	
		IF NOT f_cargar_pedido() Then bien = 1
		END IF
IF bien = 0 Then
	Return true
Else
	Return false
END IF

end function

public function boolean f_cargar_pedido ();int bien,reg,reg1,pzcj,conj
bien = 0
Dec t1,t2,por,cantidadln
Dec total_piezas,cant,cajas
String  selec,formato,clase,arti,sn
DataSTore dw_comodin_pedido
f_mensaje_proceso("Preparando Pedidos",1,100)
selec = " Select articulo,calidad From  promlindetallped " + &
        " Where promlindetallped.empresa   = '" + codigo_empresa + "'" + &
		  " And   promlindetallped.anyo      =  " + String(anyo,"#####")   + &
		  " And   promlindetallped.pedido    =  " + String(pedido,"#########") + &
		  " Group By articulo,calidad "
dw_comodin_pedido = f_cargar_cursor(selec)
situacion = "C"
reg1 = dw_comodin_pedido.RowCOunt()
IF reg1 <> 0 Then 
	For reg = 1 To reg1
		orden = orden +1

		articulo = dw_comodin_pedido.GetItemString(reg,"articulo")
		calidad  = dw_comodin_pedido.GetItemString(reg,"calidad")
		f_mensaje_proceso("Cargando Art.:"+articulo,reg,reg1)
	
			DataSTore dw_comodin_pedido2
			selec = " Select linea,piezas,articulo,caja From  promlindetallped " + &
					  " Where promlindetallped.empresa   = '" + codigo_empresa + "'" + &
					  " And   promlindetallped.anyo      =  " + String(anyo,"#####")   + &
					  " And   promlindetallped.pedido    =  " + String(pedido,"#########") + &
					  " And   promlindetallped.articulo  =  '" + articulo + "'" + &
					  " And   promlindetallped.calidad   =  '" + calidad  + "'" 

	  cantidad  = 0
	  dw_comodin_pedido2 = f_cargar_cursor(selec)
	  t2 = dw_comodin_pedido2.RowCount()
	  String v_caja
	  FOR t1 = 1 To t2
		 	arti = dw_comodin_pedido2.GetItemString(t1,"articulo")
			linea = dw_comodin_pedido2.GetItemNumber(t1,"linea")
			v_caja  = dw_comodin_pedido2.GetItemString(t1,"caja")
		   clase = f_clase_promlinped(codigo_empresa,integer(String(anyo,"#####")),dec(string(pedido,"########")),dec(string(linea,"######")))
			por   = f_porcentaje_promclasepaneles(codigo_empresa,clase)
			cantidadln = dw_comodin_pedido2.GetItemNumber(t1,"piezas")
			conj = f_conjunto_articulo(codigo_empresa,arti)
			// articulos excluidos del calculo por la familia
			sn = f_sn_familia_excluida(codigo_empresa,f_familia_articulo(codigo_empresa,arti))
			
			if sn="N" then
				IF por <> 0 Then
					if conj=0 then
						cantidadln = int(cantidadln + ((por * cantidadln / 100) + 0.99))
					End if
				END IF
			End if
			cantidad = cantidad + cantidadln
		NExt	
		pzcj= f_piezascaja_articulo(codigo_empresa,articulo,v_caja)
		IF pzcj = 0 Then
			cajas = 0
		ELSE
			cajas = Int(cantidad /pzcj)
		END IF
		IF cajas * pzcj < cantidad Then cajas = cajas + 1
		IF f_unidad_articulo(codigo_empresa,articulo) = "1" Then
			total_piezas = cajas * pzcj
		ELSE
			total_piezas = cantidad
		END IF
		formato = f_formato_articulo(codigo_empresa,articulo)
		
		INSERT INTO prompreparacionped  
         ( empresa,   
           anyo,   
           pedido,   
           articulo,   
           calidad,   
           tono,   
           calibre,   
           tipo_pallet,   
           ubicacion,   
           tipo,   
           tipo_cliente,   
           cliente,   
           expositor,   
           cantidad,   
           situacion,   
           numero_orden,
			  total_piezas,
			  cajas,
	  		  endamado,
			  formato,
			  caja)  
  VALUES ( :codigo_empresa,   
           :anyo,   
           :pedido,   
           :articulo,   
           :calidad,   
           :tono,   
           :calibre,   
           :tipo_pallet,   
           :ubicacion,   
           :tipo,   
           :tipo_cli,   
           :cliente,   
           :expositor,   
           :cantidad,   
           :situacion,   
           :orden,
			  :total_piezas,
			  :cajas,
			  "N",
			  :formato,
			  :v_caja)  ;
			  IF SQLCA.SQLCODE <> 0 Then bien = 1
			  COMMIT;
			  	 

	Next
	 Destroy dw_comodin_pedido
END IF
IF bien = 0 Then 
	Return TRUE
ELSE
	Return FALSE
END IF



end function

public subroutine f_activar_campos (boolean bool);pb_1.enabled = bool
uo_cliente.enabled = bool
ddlb_1.enabled = bool
ddlb_opcion.enabled = bool
dw_pedidos.enabled = bool
end subroutine

public subroutine f_ubicacion (integer rg);String v_ubicacion,nombretp
String montaje,zona1,zona2
String almacen,zona		 ,v_endamado
Dec    v_linea,v_existencias,v_dis
Dec{2} altura,fila,reg,v,v1,registros
String compuesto,errores,sys

v_ubicacion = dw_detalle.GetItemString(rg,"ubicacion")
IF v_ubicacion <> "" and Not IsNull(v_ubicacion)Then Return

SetNull(v_ubicacion)
dw_detalle.SetItem(rg,"ubicacion",v_ubicacion)
SetNull(tono)
SetNull(calibre)
SetNull(tipo_pallet)
SetNull(caja)
articulo = dw_detalle.GetItemString(rg,"articulo")
calidad  = dw_detalle.GetItemString(rg,"calidad")

compuesto = " Select almacen,zona,fila,altura from almubimapaart "+&
            " Where  almubimapaart.empresa  = '" + codigo_empresa + "'" +&
            " And    almubimapaart.articulo = '" + articulo       + "'" +&
				" And    almubimapaart.calidad  = '" + calidad        + "'"
				
DataStore  dw_comodin2				
dw_comodin2  =  f_cargar_cursor(compuesto)				
registros    =  dw_comodin2.RowCount()

IF registros <> 0  and Not IsNull(registros) Then
 FOR reg = 1 To registros
   almacen   = dw_comodin2.GetItemString(reg,"almacen")
   zona      = dw_comodin2.GetItemString(reg,"zona")
   fila      = dw_comodin2.GetItemNumber(reg,"fila")
   altura    = dw_comodin2.GetItemNumber(reg,"altura")
   v_ubicacion = f_componer_ubicacion(almacen,zona,fila,altura)
	// Seleccion tono,calibre,tp a esta ubicacion
		compuesto = " Select linea,tonochar,calibre,tipo_pallet,caja,existencias,altura from almlinubica "+&
      	      	" Where almlinubica.empresa     = '" + codigo_empresa + "'" +&
         	   	" And   almlinubica.ubicacion    = '" + v_ubicacion   + "'" +&
         	   	" And   almlinubica.articulo    = '" + articulo   + "'" +&
						" And   almlinubica.calidad = '" + calidad + "'" +&
						" And   almlinubica.pedido is null" + &
						" And   almlinubica.externo = 'S' " + &
						" Order by altura asc,existencias asc"
	//dw_comodin2 = f_cargar_cursor(compuesto)
	f_cargar_cursor_nuevo(compuesto, dw_comodin2)
	
	registros = dw_comodin2.RowCOunt()
	IF registros <> 0 and Not IsNull(registros) Then
	 FOR reg = 1 To registros
		tono            = dw_comodin2.GetItemString(reg,"tonochar")
		calibre         = dw_comodin2.GetItemNumber(reg,"calibre")
		v_existencias   = dw_comodin2.GetItemNumber(reg,"existencias")
		tipo_pallet     = dw_comodin2.GetItemString(reg,"tipo_pallet")
		caja            = dw_comodin2.GetItemString(reg,"caja")		
		//Asignacion solo en pallets normales
		IF f_clase_pallets(codigo_empresa,tipo_pallet) = "1" Then
			nombretp        = f_nombre_pallet_abr(codigo_empresa,tipo_pallet)
		   v_linea         = dw_comodin2.GetItemNumber(reg,"linea")
			IF Not f_bloqueo_almlinubica(codigo_empresa,v_ubicacion,v_linea) Then
				IF Not f_bloqueo_almlinubica_promocion(codigo_empresa,v_ubicacion,v_linea) Then
					dw_detalle.SetItem(rg,"ubicacion",v_ubicacion)
					v_existencias = f_calculo_total_piezas(codigo_empresa,articulo,caja,v_existencias)
					v_dis = f_calculo_total_piezas(codigo_empresa,articulo,caja,f_disponible_referencia_tipo_pallet(codigo_empresa,f_componer_ref(articulo,calidad,tono,calibre),tipo_pallet))
					IF v_dis >=  dw_detalle.GetItemNumber(rg,"total_piezas") and v_existencias >= dw_detalle.GetItemNumber(rg,"total_piezas") Then
							dw_detalle.SetItem(rg,"existencias",v_existencias)
							dw_detalle.SetItem(rg,"tonochar",tono)
							dw_detalle.SetItem(rg,"calibre",calibre)
							dw_detalle.SetItem(rg,"tipo_pallet",tipo_pallet)
							dw_detalle.SetItem(rg,"caja",caja)
							dw_detalle.SetItem(rg,"nombre_tipo_pallet",nombretp)
							dw_detalle.SetItem(rg,"disponible",v_dis)
							dw_detalle.SetItem(rg,"ubicacion",v_ubicacion)
							Return
					END IF
				END IF
			END IF
		END IF
	 NEXT
	 END IF
		//-------------------------------------------
		Return
	 NEXT
	END IF
//----------------------------------------------------------------------
//      Ubicaciones sin tono ni calibre
//----------------------------------------------------------------------
//IF (Not f_control_tono_artcal(codigo_empresa,articulo,calidad)  and &
//   Not f_control_calibre_artcal(codigo_empresa,articulo,calidad)) Then

compuesto = " Select ubicacion,linea,tonochar,calibre,tipo_pallet,caja,existencias,externo from almlinubica "+&
            " Where almlinubica.empresa     = '" + codigo_empresa + "'" +&
            " And   almlinubica.articulo    = '" + articulo   + "'" +&
				" And   almlinubica.calidad = '" + calidad + "'" +&
				" And   almlinubica.pedido is null" + &
				" Order by altura asc,existencias asc"
//dw_comodin2 = f_cargar_cursor(compuesto)
f_cargar_cursor_nuevo(compuesto, dw_comodin2)
registros = dw_comodin2.RowCOunt()

IF registros <> 0 and Not IsNull(registros) Then
 FOR reg = 1 To registros
	IF dw_comodin2.GetItemString(reg,"externo") = "S" Then
		v_ubicacion   = dw_comodin2.GetItemString(reg,"ubicacion")
		v_linea       = dw_comodin2.GetItemNumber(reg,"linea")
		tono          = dw_comodin2.GetItemString(reg,"tonochar")
		calibre       = dw_comodin2.GetItemNumber(reg,"calibre")
		v_existencias = dw_comodin2.GetItemNumber(reg,"existencias")
		tipo_pallet   = dw_comodin2.GetItemString(reg,"tipo_pallet")
		caja          = dw_comodin2.GetItemString(reg,"caja")		
		//Asignacion solo en pallets normales
		IF f_clase_pallets(codigo_empresa,tipo_pallet) = "1" Then
		nombretp = f_nombre_pallet_abr(codigo_empresa,tipo_pallet)
		
		IF Not f_bloqueo_almlinubica(codigo_empresa,v_ubicacion,v_linea) Then
			IF Not f_bloqueo_almlinubica_promocion(codigo_empresa,v_ubicacion,v_linea) Then
				v_dis = f_calculo_total_piezas(codigo_empresa,articulo,caja,f_disponible_referencia_tipo_pallet(codigo_empresa,f_componer_ref(articulo,calidad,tono,calibre),tipo_pallet))
				v_existencias = f_calculo_total_piezas(codigo_empresa,articulo,caja,v_existencias)						
				IF v_dis >= dw_detalle.GetItemNumber(rg,"total_piezas") and v_existencias >= dw_detalle.GetItemNumber(rg,"total_piezas") Then
					dw_detalle.SetItem(rg,"ubicacion",v_ubicacion)
					dw_detalle.SetItem(rg,"existencias",v_existencias)
					dw_detalle.SetItem(rg,"tonochar",tono)
					dw_detalle.SetItem(rg,"calibre",calibre)
					dw_detalle.SetItem(rg,"tipo_pallet",tipo_pallet)
					dw_detalle.SetItem(rg,"caja",caja)					
					dw_detalle.SetItem(rg,"disponible",v_dis)
					dw_detalle.SetItem(rg,"nombre_tipo_pallet",nombretp)
					dw_detalle.SetItem(rg,"ubicacion",v_ubicacion)
				Return
				END IF
			END IF
		END IF
	END IF
 END IF
 NEXT
//END IF
END IF

destroy dw_comodin2
end subroutine

public subroutine f_ubicacion_endamado (integer rg);String codigo_endamado,control_tono,control_calibre,sel,ref1,x_articulo[100],x_calidad[100],x_ubicacion[100],nulo,ub,x_tipo_pallet[100],x_caja[100],x_tono[100]
Integer r ,r1,a,a1,v_bien,contador,b1,b
Dec x_dis[100],x_linea[100],x_calibre[100],x_registro[100],x_existencias[100],total_piezas
SetNUll(nulo)
dw_detalle.SetItem(rg,"ubicacion",nulo)
contador = 1
x_articulo[contador]        = dw_detalle.GetItemString(rg,"articulo")
x_calidad[contador]         = dw_detalle.GetItemString(rg,"calidad")
total_piezas = dw_detalle.GetItemNumber(rg,"total_piezas")
codigo_endamado = dw_detalle.GetItemString(rg,"codigo_endamado")
v_bien = 0
  SELECT almendamados.tono,almendamados.calibre  
  INTO   :control_tono,:control_calibre  
  FROM   almendamados  
  WHERE  almendamados.empresa = :codigo_empresa 
  AND    almendamados.codigo  = :codigo_endamado;
  
r1 = dw_detalle.RowCount()
Sel = " Select tonochar,calibre,tipo_pallet,caja,linea,ubicacion,existencias from almlinubica " + &
		" Where  empresa   = '" +codigo_empresa+ "'"+&
		" And    articulo  = '" +x_articulo[contador]+ "'"+&
		" And    calidad   = '" +x_calidad[contador] + "'"+&
		" And    pedido    is  null"+&
		" And    externo = 'S' "
 DataStore dw_comodin,dw_comodin2		
// dw_comodin = f_cargar_cursor(sel)
 f_cargar_cursor_nuevo(sel, dw_comodin2)
 a1 = dw_comodin.RowCount()
IF a1 = 0 Then
	v_bien = 1
ELSE
	For a = 1 To a1
		v_bien = 0
		contador = 1
		//Asignacion solo en pallets normales
//		IF f_clase_pallets(codigo_empresa,dw_comodin.GetItemString(a,"tipo_pallet")) = "1" Then
		x_tono[contador]        =  dw_comodin.GetItemString(a,"tonochar")
		x_tipo_pallet[contador] =  dw_comodin.GetItemString(a,"tipo_pallet")
		x_caja[contador] =  dw_comodin.GetItemString(a,"caja")		
		x_existencias[contador] =  dw_comodin.GetItemNumber(a,"existencias")
		x_calibre[contador]     =  dw_comodin.GetItemNumber(a,"calibre")
		x_ubicacion[contador]   =  dw_comodin.GetItemString(a,"ubicacion")
		x_linea[contador]       =  dw_comodin.GetItemNumber(a,"linea")
		x_registro[contador]    = rg
//		f_mensaje("Empezamos","Tono.:"+String(x_tono[contador])+ "calibre.:"+String(x_calibre[contador]))
		x_dis[contador] = f_calculo_total_piezas(codigo_empresa,x_articulo[contador],x_caja[contador],f_disponible_referencia_tipo_pallet(codigo_empresa,f_componer_ref(x_articulo[contador],x_calidad[contador],x_tono[contador],x_calibre[contador]),x_tipo_pallet[contador]))
		IF  x_dis[contador] < total_piezas Then 
			v_bien = 1
		ELSE	
			For r = 1 To r1
		 	ub =dw_detalle.GetItemString(r,"ubicacion") 
		 	IF ub = "" or IsNull(ub) Then
			IF dw_detalle.GetItemString(r,"codigo_endamado") = codigo_endamado Then
				contador = contador + 1
				x_articulo[contador] = dw_detalle.GetItemString(r,"articulo")
				x_calidad[contador]= dw_detalle.GetItemString(r,"calidad")
					Sel = " Select tonochar,calibre,tipo_pallet,caja,linea,ubicacion,existencias from almlinubica " + &
  						" Where  empresa   = '" +codigo_empresa+ "'"+&
						" And    articulo  = '" +x_articulo[contador]+ "'"+&
						" And    calidad   = '" +x_calidad[contador] + "'"+&
						" And    pedido    is  null"+&
						" And    externo = 'S' "
						IF control_tono    ="S" Then sel=sel + " And tonochar   ='" +String(x_tono[1],"#0")+"'" 
						IF control_calibre ="S" Then sel=sel + " And calibre   =" +String(x_calibre[1],"#0") 
						//dw_comodin2 = f_cargar_cursor(sel)
						f_cargar_cursor_nuevo(sel, dw_comodin2)
						b1 = dw_comodin2.RowCount()
						IF b1 = 0 Then
							v_bien = 1
						ELSE
							For b = 1 To b1
	 							IF f_clase_pallets(codigo_empresa,dw_comodin2.GetItemSTring(b,"tipo_pallet")) = "1" Then
 		    				 		x_tono[contador]         =  dw_comodin2.GetItemString(b,"tonochar")
									x_tipo_pallet[contador]  =  dw_comodin2.GetItemSTring(b,"tipo_pallet")
									x_caja[contador]         =  dw_comodin2.GetItemSTring(b,"caja")									
								 	x_calibre[contador]      =  dw_comodin2.GetItemNumber(b,"calibre")
								 	x_existencias[contador]  =  dw_comodin2.GetItemNumber(b,"existencias")
								 	x_ubicacion[contador]    =  dw_comodin2.GetItemString(b,"ubicacion")
								 	x_linea[contador]        =  dw_comodin2.GetItemNumber(b,"linea")
								 	x_registro[contador]     = r
								 	x_dis[contador] = f_calculo_total_piezas(codigo_empresa,x_articulo[contador],x_caja[contador],f_disponible_referencia_tipo_pallet(codigo_empresa,f_componer_ref(x_articulo[contador],x_calidad[contador],dw_comodin2.GetItemString(b,"tonochar"),dw_comodin2.GetItemNumber(b,"calibre")),dw_comodin2.GetItemSTring(b,"tipo_pallet"))) 
							    	IF x_dis[contador] < dw_detalle.GetItemNumber(r,"total_piezas") Then v_bien = 1
								 	Exit
							  	ELSE
									IF b = b1 Then	v_bien = 1
							 	END IF
							Next
						END IF
				END IF
			END IF
		Next
//	 END IF
		IF v_bien = 0 Then Exit
	END IF
	Next
	
	IF v_bien = 0 Then
		FOR a = 1 To contador
				dw_detalle.SetItem(x_registro[a],"disponible",x_dis[a])
				dw_detalle.SetItem(x_registro[a],"tonochar",x_tono[a])
				dw_detalle.SetItem(x_registro[a],"calibre",x_calibre[a])
				x_existencias[a] = f_calculo_total_piezas(codigo_empresa,dw_detalle.GetItemSTring(x_registro[a],"articulo"),x_caja[a],x_existencias[a])
				dw_detalle.SetItem(x_registro[a],"existencias",x_existencias[a])
				dw_detalle.SetItem(x_registro[a],"ubicacion",x_ubicacion[a])
				dw_detalle.SetItem(x_registro[a],"tipo_pallet",x_tipo_pallet[a])
				dw_detalle.SetItem(x_registro[a],"caja",x_caja[a])				
				dw_detalle.SetItem(x_registro[a],"nombre_tipo_pallet",f_nombre_pallet_abr(codigo_empresa,x_tipo_pallet[a]))
		NEXT
	END IF
END IF



destroy dw_comodin2
end subroutine

public subroutine f_salida_almacen_todo ();Integer r, r1
ser = "S"
r1 = dw_detalle.RowCount()
IF r1 = 0 Then return
For r = 1 To r1
f_salida_almacen(r)	
f_mensaje_proceso("Procesando salida almacen",r,r1)
Next
IF ser = "N" Then
	f_mensaje("Control Proceso","Existen lineas sin preparar")
END IF
end subroutine

public subroutine f_salida_almacen (decimal arg_reg);Integer vbien
String vubicacion
vbien = 0
str_almlinubicahis ubihis
str_almlinubica ubi
str_almmovhis mov
IF dw_detalle.GetItemString(arg_reg,"situacion")= "P" Then
//	f_mensaje("! A t e n c i ó n ","No se puede preparar, linea ya preparada")
	Return 
end if

 vubicacion = dw_detalle.GetItemString(arg_reg,"ubicacion")
 IF vubicacion = "" or IsNull(vubicacion) Then
	ser = "N"
	return 
END IF
 ubihis.ubicacion = vubicacion
 ubihis.usuario       = nombre_usuario
 ubihis.empresa       = codigo_empresa
 ubihis.anyo          = year(Today())
 ubihis.almacen       = f_almacen_ubicacion(vubicacion)
 ubihis.articulo      = dw_detalle.GetItemString(arg_reg,"articulo")
 ubihis.calidad       = dw_detalle.GetItemString(arg_reg,"calidad")
 ubihis.tonochar      = dw_detalle.GetItemString(arg_reg,"tonochar")
 ubihis.calibre       = dw_detalle.GetItemNumber(arg_reg,"calibre")
 ubihis.fecha         = DateTime(Today())
 ubihis.f_alta        = Datetime(today(),now())
 ubihis.observaciones = ""
 ubihis.tipomov       = "201"
 ubihis.tipo_pallet   = dw_detalle.GetItemString(arg_reg,"tipo_pallet")
 ubihis.caja          = dw_detalle.GetItemString(arg_reg,"caja") 
 SELECT  articulos.empresa,articulos.codigo,articulos.familia,   
         articulos.formato,articulos.modelo,articulos.unidad,articulos.sector
    INTO :ubihis.empresa,:ubihis.articulo,:ubihis.familia,:ubihis.formato,   
         :ubihis.modelo, :ubihis.tipo_unidad,:ubihis.sector  
    FROM articulos  
   WHERE articulos.empresa = :ubihis.empresa 
	AND   articulos.codigo  = :ubihis.articulo;
   IF SQLCA.SQLCode<>0 THEN vbien=1
 ubihis.referencia   = f_componer_ref(ubihis.articulo,&
                                      ubihis.calidad,ubihis.tonochar,&
                                      ubihis.calibre)
IF f_conversion_piezas_cantidad(ubihis.empresa,ubihis.articulo,ubihis.caja,dw_detalle.GetItemNumber(arg_reg,"total_piezas")) 	> f_disponible_referencia_tipo_pallet(codigo_empresa,ubihis.referencia,ubihis.tipo_pallet) Then
	ser = "N"
	Return
END IF
ubi.empresa     =  ubihis.empresa
ubi.almacen     =  ubihis.almacen
ubi.articulo    =  ubihis.articulo
ubi.familia     =  ubihis.familia
ubi.formato     =  ubihis.formato
ubi.modelo      =  ubihis.modelo
ubi.calidad     =  ubihis.calidad
ubi.tonochar    =  ubihis.tonochar
ubi.calibre     =  ubihis.calibre
ubi.tipo_pallet = ubihis.tipo_pallet
ubi.sector      = ubihis.sector
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad  =  ubihis.tipo_unidad
ubi.referencia   =  ubihis.referencia
ubi.f_alta       =  DateTime(today(),now())
ubihis.zona      =  f_zona_ubicacion(vubicacion)
ubihis.fila      =  f_fila_ubicacion(vubicacion)
ubihis.altura    =  f_altura_ubicacion(vubicacion)
ubihis.cantidads = f_conversion_piezas_cantidad(ubihis.empresa,ubihis.articulo,ubihis.caja,dw_detalle.GetItemNumber(arg_reg,"total_piezas"))
ubihis.cantidade = 0
ubi.zona            = ubihis.zona
ubi.fila            = ubihis.fila
ubi.altura          = ubihis.altura
ubi.existencias     = ubihis.cantidads
ubi.ubicacion       = ubihis.ubicacion

mov.empresa          = ubihis.empresa
mov.almacen          = ubihis.almacen
mov.anyo             = ubihis.anyo
mov.origen           = "8"
mov.articulo         = ubihis.articulo
mov.fechmov          = ubihis.fecha
mov.tipomov          = ubihis.tipomov
mov.cantidade        = ubihis.cantidade
mov.cantidads        = ubihis.cantidads
//mov.precio           = ?????????????????
mov.codtercero       = dw_pedidos.GetItemString(dw_pedidos.GetRow(),"cliente")
mov.numdoc           = String(dw_pedidos.GetItemnumber(dw_pedidos.GetRow(),"pedido"),"########")
mov.situacion        = "N"
mov.observaciones    = ""
SetNull(mov.punteado)
mov.antexist=0      
mov.familia        = ubihis.familia
mov.formato        = ubihis.formato
mov.modelo         = ubihis.modelo
mov.calidad        = ubihis.calidad
mov.tonochar       = ubihis.tonochar
mov.calibre        = ubihis.calibre
mov.tipo_unidad    = ubihis.tipo_unidad
mov.tipo_pallet    = ubihis.tipo_pallet
mov.referencia     = ubihis.referencia
mov.f_alta         = DateTime(today(),now())
mov.sector         = ubihis.sector
  ubihis.orden   = f_almparam_numorden(codigo_empresa,Year(Today()))
  ubihis.nummov  = f_almparam_nummov(codigo_empresa,Year(Today()))
  mov.nummov=ubihis.nummov    
// Variables para cargar el cursor

      Dec cur_pedido,cur_linea,cur_anyo
      String  cur_empresa,cur_almacen

      decimal{4}  cur_existencias,cantidad_pendiente,cantidad_borrada
      string  cur_referencia,cur_ubicacion,cur_tipo_pallet


   // Primero actualizo la salida global //
  //-------------------------------------//
  // En el historico de ubicaciones
  IF NOT f_insert_almlinubicahis(ubihis) Then  vbien=1
   IF NOT f_actualiza_numorden(codigo_empresa,Year(Today()),ubihis.orden) THEN
     vbien=1
   END IF
//----------------------------------------------
// Borro en las ubicaciones correspondientes
//----------------------------------------------

Integer Registros,x1
STring sele
sele= " Select * from almlinubica " + &
		" Where empresa     = '"  +  ubi.empresa     + "'" + &
		" and   ubicacion   = '"  +  ubi.ubicacion   + "'" + &
		" and   referencia  = '"  +  ubi.referencia  + "'" + &
		" and   tipo_pallet  = '"  + ubi.tipo_pallet + "'" + &
		" and   pedido Is Null"
		
DataStore dw_comodin_ubi
//dw_comodin_ubi = f_cargar_cursor(sele)
f_cargar_cursor_nuevo(sele, dw_comodin_ubi)
registros = dw_comodin_ubi.RowCount()
cantidad_borrada=0
If registros=0  or IsNull(registros)Then 
	ser = "N"
	Return
END IF

If registros<>0 Then
 For x1 = 1 To Registros
    cur_pedido        =  dw_comodin_ubi.GetItemNumber(x1,"pedido")
    cur_linea         =  dw_comodin_ubi.GetItemNumber(x1,"linea")
    cur_existencias   =  dw_comodin_ubi.GetItemNumber(x1,"existencias")
    cur_tipo_pallet   =  dw_comodin_ubi.GetItemString(x1,"tipo_pallet")
    IF ubihis.cantidads > cur_existencias Then return
     IF ubihis.cantidads = cur_existencias THEN 
         DELETE FROM almlinubica
         WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
               ( almlinubica.ubicacion = :ubi.ubicacion ) AND  
               ( almlinubica.linea     = :cur_linea ) USING SQLCA   ;
         IF SQLCA.SQLCode<>0 THEN 
				f_mensaje("Error en proceso","Error el modificar ubicaciones")
				vbien=1
			END IF
				
     ELSE
         cur_existencias=cur_existencias - ubihis.cantidads
         UPDATE almlinubica  
         SET existencias = :cur_existencias  
         WHERE almlinubica.empresa   = :ubi.empresa 
			AND   almlinubica.ubicacion = :ubi.ubicacion 
			AND   almlinubica.linea     = :cur_linea USING SQLCA;
               IF SQLCA.SQLCode<>0 THEN 
						f_mensaje("Error en proceso","Error el modificar ubicaciones")
						vbien=1
					END IF
   END IF
	EXIT
NEXT
Destroy dw_comodin_ubi

// Grabo el movimiento en el historico
  IF NOT f_insert_almmovhis(mov) Then 
	vbien=1
	f_mensaje("","Error insertar almmvhis")
  END IF
  IF NOT f_actualiza_nummov(codigo_empresa,Year(Today()),mov.nummov) THEN
     vbien=1
	  	f_mensaje("","Error actualizar  almmvhis")
  END IF
END IF
  IF Not f_preparar_linea(arg_reg) Then 
	vbien = 1
		f_mensaje("","Error al preparar linea")
END IF

  CHOOSE CASE vbien
	CASE 1
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	CASE 0
   		dw_detalle.SetItem(arg_reg,"situacion","P")
	     COMMIT USING SQLCA;
  CASE ELSE
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
  END CHOOSE



end subroutine

public function boolean f_preparar_linea (decimal reg);Integer   vbien 
vbien = 0
Dec  vorden,vcantidad,vtono,vtotal_piezas,vcajas,vcalibre
String vtipo_pallet,vubicacion

vorden = dw_detalle.GetItemNumber(reg,"numero_orden")
vtono = dw_detalle.GetItemNumber(reg,"tono")
vcalibre = dw_detalle.GetItemNumber(reg,"calibre")
vtipo_pallet = dw_detalle.GetItemString(reg,"tipo_pallet")
vubicacion = dw_detalle.GetItemString(reg,"ubicacion")
vtotal_piezas = dw_detalle.GetItemNumber(reg,"total_piezas")
vcajas = dw_detalle.GetItemNumber(reg,"cajas")

  UPDATE prompreparacionped  
     SET prompreparacionped.tono         = :vtono,   
         prompreparacionped.calibre      = :vcalibre,   
         prompreparacionped.tipo_pallet  = :vtipo_pallet,   
         prompreparacionped.ubicacion    = :vubicacion,   
         prompreparacionped.total_piezas = :vtotal_piezas,   
         prompreparacionped.cajas        = :vcajas,
			prompreparacionped.situacion    = "P"
   WHERE prompreparacionped.empresa = :codigo_empresa
	AND   prompreparacionped.numero_orden = :vorden;


iF vbien = 0 Then
	return True
Else
	return FALSE
End If

end function

public subroutine f_cargar ();Integer bien
bien = 0
   IF  Not f_cargar_lineas() Then bien = 1
	IF  Not f_cargar_detalle() Then bien = 1
   IF  Not f_orden_endamados() Then bien = 1
	IF  Not f_asignar_ubicaciones() Then bien = 1
IF bien = 0 Then
	COMMIT;
	dw_detalle.SetReDraw(TRUE)
	dw_detalle.visible = TRUE
	dw_detalle.SetSort("situacion,codigo_endamado,articulo")
	dw_detalle.Sort()
	f_activar_campos(FALSE)
	dw_detalle.TriggerEvent(RowFocusChanged!)
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso"," La Operacion no se actualiza")
END IF

end subroutine

public function boolean f_asignar_ubicaciones ();Integer r, r1
String ub

r1 = dw_detalle.RowCount()
IF r1 = 0 Then return True
For r = 1 To r1
	IF dw_detalle.getItemString(r,"situacion") <> "P" Then
	   ub = dw_detalle.getItemString(r,"ubicacion") 
  	   IF ub = ""  or IsNull(ub) Then
		   IF dw_detalle.GetItemString(r,"situacion")<> "P" Then
			   IF dw_detalle.GetItemString(r,"endamado")= "N" Then
				     f_ubicacion(r)
			    ELSE
				     f_ubicacion_endamado(r)
			   END IF
		   END IF
	   END IF
	END IF
	f_mensaje_proceso("Asignando Ubicaciones",r,r1)
Next

Return TRUE
end function

public function boolean f_cargar_detalle ();Int  reg,reg1,r,ele,cajas,numero_orden
Dec total_piezas
String selec,nombre_articulo,nombre_calidad,nombre_tipo_pallet,endamado
DataStore  dw_comodin
f_mensaje_proceso("Cargando lineas a preparar",1,100)
selec =" Select * from prompreparacionped "+ &
       " Where empresa = '" + codigo_empresa + "'" +&
		 " And   anyo    = " + String(anyo,"####")+ &
		 " And   pedido  = " + String(pedido,"##########")
		 
//dw_comodin = f_cargar_cursor(selec)
f_cargar_cursor_nuevo(selec, dw_comodin)
reg1= dw_comodin.RowCOunt()
r = 0
dw_detalle.SetReDraw(FALSE)
IF reg1 <> 0 Then
	For reg = 1 To reg1
		r = r +1
		dw_detalle.InsertRow(r)
		articulo    = dw_comodin.getItemString(reg,"articulo")
   	endamado    = dw_comodin.getItemString(reg,"endamado")
		situacion   = dw_comodin.getItemString(reg,"situacion")
		calidad     = dw_comodin.getItemString(reg,"calidad")
		tono        = dw_comodin.getItemString(reg,"tonochar")
		numero_orden  = dw_comodin.getItemNumber(reg,"numero_orden")
		calibre     = dw_comodin.getItemnumber(reg,"calibre")
		tipo_pallet = dw_comodin.getItemString(reg,"tipo_pallet")
		caja        = dw_comodin.getItemString(reg,"caja")		
		ubicacion   = dw_comodin.getItemString(reg,"ubicacion")
		cantidad    = dw_comodin.getItemNumber(reg,"cantidad")
		total_piezas = dw_comodin.getItemNumber(reg,"total_piezas")
		cajas       = dw_comodin.getItemNumber(reg,"cajas")
		dw_detalle.SetItem(r,"empresa",codigo_empresa)
		dw_detalle.SetItem(r,"anyo",anyo)
		dw_detalle.SetItem(r,"pedido",pedido)
		dw_detalle.SetItem(r,"articulo",articulo)
		dw_detalle.SetItem(r,"endamado",endamado)
		dw_detalle.SetItem(r,"tipo_unidad",f_unidad_articulo(codigo_empresa,articulo))
		dw_detalle.SetItem(r,"calidad",calidad)
		dw_detalle.SetItem(r,"situacion",situacion)
   	dw_detalle.SetItem(r,"cantidad",cantidad)
		dw_detalle.SetItem(r,"total_piezas",total_piezas)
		dw_detalle.SetItem(r,"tonochar",tono)
		dw_detalle.SetItem(r,"numero_orden",numero_orden)
		dw_detalle.SetItem(r,"calibre",calibre)
		dw_detalle.SetItem(r,"tipo_pallet",tipo_pallet)
		dw_detalle.SetItem(r,"caja",caja)		
		dw_detalle.SetItem(r,"ubicacion",ubicacion)
		nombre_articulo     = f_nombre_articulo(codigo_empresa,articulo)
		nombre_calidad      = f_nombre_calidad_abr(codigo_empresa,calidad)
		nombre_tipo_pallet  = f_nombre_pallet_abr(codigo_empresa,tipo_pallet)
		dw_detalle.SetItem(r,"nombre_articulo",nombre_articulo)
		dw_detalle.SetItem(r,"nombre_tipo_pallet",nombre_tipo_pallet)
		dw_detalle.SetItem(r,"nombre_calidad",nombre_calidad)
		dw_detalle.SetItem(r,"cajas",cajas)
		
	f_mensaje_proceso("Procesando lineas a preparar",reg,reg1)
	Next
	Destroy dw_comodin
END IF
Return TRUE
end function

public function boolean f_orden_endamados ();Integer r, r1,registro,d,d1,numero,f,f1
String  articulo1,articulo2,control_tono,control_calibre
String v_ubicacion,sel,codigo_endamado
DataStore dw_comodin_endamados		
r1 = dw_detalle.RowCount()
d1 = r1
IF r1 = 0 Then return TRUE

For r = 1 To r1
	
	IF dw_detalle.GetItemString(r,"endamado") = "N" Then
		registro = r
		articulo1 = dw_detalle.GetItemString(r,"articulo")
		f_mensaje_proceso("Endamados Art: "+ articulo1,r,r1)
		   Select  Max(codigo) Into :codigo_endamado from almendamadosdetalle
			Where   empresa  = :codigo_empresa
			And     articulo = :articulo1;
			IF IsNUll(codigo_endamado) Then codigo_endamado = ""

			
			
      IF codigo_endamado <> "" Then			
		For d = 1 To d1
			IF dw_detalle.GetItemString(d,"endamado") = "N" and registro <> d Then
				 articulo2 = dw_detalle.GetItemString(d,"articulo")
  	   	Select count(*) Into :numero from almendamados
			Where  empresa  = :codigo_empresa
			And    codigo  In (Select   codigo From almendamadosdetalle
			                     Where  empresa  = :codigo_empresa
										And    codigo   = :codigo_endamado
										And    articulo = :articulo2);
			IF IsNull(numero) Then numero =0
	 	   IF numero <> 0 Then
					Select count(*) Into :numero From almendamadosdetalle
					Where  almendamadosdetalle.empresa  = :codigo_empresa
					And    almendamadosdetalle.codigo   = :codigo_endamado
					And    almendamadosdetalle.articulo = :articulo1;
					IF IsNull(numero) Then numero = 0
					IF numero <> 0 Then
					  SELECT  almendamados.tono,almendamados.calibre  
					  INTO    :control_tono,:control_calibre  
					  FROM    almendamados  
					  WHERE   almendamados.empresa = :codigo_empresa 
					  AND     almendamados.codigo  = :codigo_endamado;
					  IF control_tono = "N" and control_calibre= "N" Then
							dw_detalle.SetItem(registro,"endamado","N")
					  ELSE
						dw_detalle.SetItem(registro,"endamado","S")
					  END IF
						dw_detalle.SetItem(registro,"codigo_endamado",codigo_endamado)
						dw_detalle.SetItem(d,"endamado","S")
						dw_detalle.SetItem(d,"codigo_endamado",codigo_endamado)
					END IF
				 END IF
			END IF
		Next
	END IF
END IF
	
Next
dw_detalle.SelectRow(0,FALSE)
dw_detalle.SelectRow(1,TRUE)
IF dw_detalle.RowCOunt() <>0 Then dw_detalle.SetRow(1)
Return TRUE
end function

on w_preparacion_pedidos_promocion.create
int iCurrent
call super::create
this.st_conpromped2=create st_conpromped2
this.uo_cliente=create uo_cliente
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.ddlb_1=create ddlb_1
this.ddlb_opcion=create ddlb_opcion
this.dw_ubicaciones=create dw_ubicaciones
this.dw_detalle=create dw_detalle
this.dw_pedidos=create dw_pedidos
this.dw_albaranes=create dw_albaranes
this.st_disponible=create st_disponible
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_conpromped2
this.Control[iCurrent+2]=this.uo_cliente
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.uo_manejo
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.ddlb_opcion
this.Control[iCurrent+9]=this.dw_ubicaciones
this.Control[iCurrent+10]=this.dw_detalle
this.Control[iCurrent+11]=this.dw_pedidos
this.Control[iCurrent+12]=this.dw_albaranes
this.Control[iCurrent+13]=this.st_disponible
end on

on w_preparacion_pedidos_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_conpromped2)
destroy(this.uo_cliente)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.ddlb_1)
destroy(this.ddlb_opcion)
destroy(this.dw_ubicaciones)
destroy(this.dw_detalle)
destroy(this.dw_pedidos)
destroy(this.dw_albaranes)
destroy(this.st_disponible)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Preparacion de Pedidos (Promocion)"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana
sal = "N"
dw_pedidos.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_ubicaciones.SetTransObject(SQLCA)
dw_albaranes.SetTransObject(SQLCA)

ddlb_1.text ="Si" 

ddlb_opcion.text = "Expositor"

f_control()
f_mascara_columna(dw_detalle,"cajas",f_mascara_decimales(0))
f_mascara_columna(dw_detalle,"total_piezas",f_mascara_decimales(0))
// Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
		sal ="S"
      anyo    =  Dec(istr_parametros.s_argumentos[2])
      pedido  =  Dec(istr_parametros.s_argumentos[3])
		istr_parametros.i_nargumentos=0
		f_cargar()
		Return
   END IF
f_activar_campo(uo_cliente.em_campo)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_pedidos)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_pedidos)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_pedidos)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_pedidos)
end event

event activate;call super::activate;w_preparacion_pedidos_promocion = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_preparacion_pedidos_promocion
integer x = 654
integer y = 664
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_preparacion_pedidos_promocion
integer taborder = 80
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_preparacion_pedidos_promocion
integer y = 44
integer width = 2139
end type

type st_conpromped2 from statictext within w_preparacion_pedidos_promocion
integer x = 14
integer y = 208
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_preparacion_pedidos_promocion
integer x = 471
integer y = 204
integer width = 1202
integer height = 88
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;IF ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
	ue_datawindow ="dw_ayuda_clientes"
	ue_filtro = ""
Else
	ue_titulo = "Selección de no cliente"
	ue_datawindow ="dw_ayuda_vencliproforma"
	ue_filtro = ""
End if
end event

event modificado;call super::modificado;
if ddlb_1.text = "Si" then
	   uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
	else
      uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)		
End if

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
end if 

f_control()
end event

type pb_1 from upb_salir within w_preparacion_pedidos_promocion
integer x = 2688
integer y = 32
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type pb_imprimir from upb_imprimir within w_preparacion_pedidos_promocion
integer x = 2693
integer y = 216
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;Integer rg
Dec vanyo,vpedido
rg = dw_pedidos.GetRow()
IF rg = 0 Then return
vanyo = dw_pedidos.GetItemNumber(rg,"anyo")
vpedido = dw_pedidos.GetItemNumber(rg,"pedido")
dw_listado.Retrieve(codigo_empresa,vanyo,vpedido)
f_imprimir_datawindow(dw_listado)
end event

type dw_listado from datawindow within w_preparacion_pedidos_promocion
boolean visible = false
integer x = 82
integer y = 8
integer width = 494
integer height = 120
integer taborder = 90
boolean bringtotop = true
string dataobject = "report_preparacion_pedidos_promocion"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_preparacion_pedidos_promocion
integer x = 2217
integer y = 168
end type

event valores;call super::valores;dw_data=dw_pedidos
f_activar_campo(uo_cliente.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type ddlb_1 from dropdownlistbox within w_preparacion_pedidos_promocion
integer x = 261
integer y = 204
integer width = 210
integer height = 260
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551093
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_opcion from dropdownlistbox within w_preparacion_pedidos_promocion
event modified pbm_cbnmodified
integer x = 1673
integer y = 204
integer width = 485
integer height = 364
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Panel de Mano","Expositor"}
end type

event modified;uo_cliente.TriggerEvent("modificado")
end event

type dw_ubicaciones from datawindow within w_preparacion_pedidos_promocion
boolean visible = false
integer x = 9
integer y = 336
integer width = 1760
integer height = 1084
integer taborder = 30
boolean titlebar = true
string title = "Ubicaciones alternativas"
string dataobject = "dw_int_preparacion_pedidos_promocion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;String var_almacen,var_zona,var_tipo_pallet,var_caja,var_articulo,var_calidad,var_tono
Dec var_calibre,var_existencias
Dec    var_fila,var_altura,var_disponible,tot_piezas
IF row = 0 Then Return
// Comprueba si hay suficiente en la ubicacion
tot_piezas      = dw_detalle.GetItemNumber(dw_detalle.GetRow(),"total_piezas")

if tot_piezas>dec(st_disponible.text) then
   f_mensaje("Control de Stock","No hay disponible suficiente")
	Return
End if

var_almacen     = GetItemString(row,"almlinubica_almacen")
var_zona        = GetItemString(row,"zona")
var_fila        = GetItemNumber(row,"fila")
var_altura      = GetItemNumber(row,"altura")
var_tono        = GetItemString(row,"tonochar")
var_calibre     = GetItemNumber(row,"almlinubica_calibre")
var_tipo_pallet = GetItemString(row,"almlinubica_tipo_pallet")
var_caja        = GetItemString(row,"almlinubica_caja")
var_articulo    = GetItemString(row,"almlinubica_articulo")
var_calidad     = GetItemString(row,"almlinubica_calidad")
var_existencias = GetItemNumber(row,"almlinubica_existencias")
var_existencias = f_calculo_total_piezas(codigo_empresa,var_articulo,var_caja,var_existencias)

IF f_ubi_exist(codigo_empresa,var_almacen,var_zona,var_fila,var_altura) Then
	dw_detalle.SetItem(dw_detalle.GetRow(),"ubicacion",f_componer_ubicacion(var_almacen,var_zona,var_fila,var_altura))
	dw_detalle.SetItem(dw_detalle.GetRow(),"tonochar",var_tono)
	dw_detalle.SetItem(dw_detalle.GetRow(),"existencias",var_existencias)
	dw_detalle.SetItem(dw_detalle.GetRow(),"calibre",var_calibre)
	dw_detalle.SetItem(dw_detalle.GetRow(),"tipo_pallet",var_tipo_pallet)
	dw_detalle.SetItem(dw_detalle.GetRow(),"caja",var_caja)	
	dw_detalle.SetItem(dw_detalle.GetRow(),"nombre_tipo_pallet",f_nombre_pallet_abr(codigo_empresa,var_tipo_pallet))
	var_disponible = f_disponible_referencia_tipo_pallet(codigo_empresa,f_componer_ref(var_articulo,var_calidad,var_tono,var_calibre),var_tipo_pallet)
	var_disponible = f_calculo_total_piezas(codigo_empresa,var_articulo,var_caja,var_disponible)
	dw_detalle.SetItem(dw_detalle.GetRow(),"disponible",var_disponible)
 ELSE
	f_mensaje("Error en datos","La ubicacion no existe")
END IF

st_disponible.visible = False
This.visible          = FALSE
dw_detalle.enabled    = TRUE
dw_detalle.setfocus()

IF dw_detalle.GetItemString(dw_detalle.getRow(),"tipo_unidad")= "0" Then
	dw_detalle.SetColumn("total_piezas")
ELSE
	dw_detalle.SetColumn("cajas")
END IF


	
	
end event

event clicked;IF f_objeto_datawindow(dw_ubicaciones) = "salir" Then
	st_disponible.visible = False
	dw_detalle.enabled = TRUE
	Reset()
	visible = FALSE
	Return
END IF
String var_refe,var_tipo_pallet,var_articulo,var_caja
dec canti
var_refe        = this.GetItemString(row,"almlinubica_referencia")
var_tipo_pallet = this.GetItemString(row,"almlinubica_tipo_pallet")
var_caja        = this.GetItemString(row,"almlinubica_caja")
var_articulo    = this.GetItemString(row,"almlinubica_articulo")
canti  = f_disponible_referencia_tipo_pallet_caja(codigo_empresa,var_refe,var_tipo_pallet,var_caja)
st_disponible.text = String(f_calculo_total_piezas(codigo_empresa,var_articulo,var_caja,canti),f_mascara_decimales(0))
end event

type dw_detalle from u_datawindow_consultas within w_preparacion_pedidos_promocion
boolean visible = false
integer y = 336
integer width = 2834
integer height = 1084
integer taborder = 10
string dataobject = "dw_preparacion_pedidos_promocion2"
borderstyle borderstyle = styleraised!
end type

event rbuttondown;call super::rbuttondown;String  var_calidad,var_tipo_pallet,var_articulo
Dec{0}  var_tono,var_calibre
IF GetRow()= 0 Then Return
IF This.GetItemString(GetRow(),"situacion") = "P" Then Return
var_articulo    = This.GetItemString(GetRow(),"articulo") 
var_calidad     = This.GetItemString(GetRow(),"calidad")  
this.enabled = FALSE
dw_ubicaciones.visible = TRUE
st_disponible.visible  = True
dw_ubicaciones.Retrieve(codigo_empresa,var_articulo,var_calidad)


end event

event clicked;call super::clicked;IF f_objeto_datawindow(dw_detalle)= "preparar_linea" Then
	IF dw_detalle.GetRow() = 0 Then Return
	IF Not f_bloquear_almacen(w_preparacion_pedidos_promocion.title) Then
		f_salida_almacen(dw_detalle.GetRow())
		f_desbloquear_almacen(w_preparacion_pedidos_promocion.title)
	END IF
	Return
END IF

IF f_objeto_datawindow(dw_detalle)= "preparar_todo" Then
	IF dw_detalle.GetRow() = 0 Then Return
	IF MessageBox("Confirmacion del proceso","¿Desea Preparar El pedido?",Question!,YesNo!)= 1 Then
		IF Not f_bloquear_almacen(w_preparacion_pedidos_promocion.title) Then
			f_salida_almacen_todo()
			f_desbloquear_almacen(w_preparacion_pedidos_promocion.title)
		END IF
		
		Return
	END IF
END IF


IF f_objeto_datawindow(dw_detalle)= "salir" Then
	Dec numero
		Select Count(*) Into :numero From prompreparacionped
		Where  prompreparacionped.empresa = :codigo_empresa
		and    prompreparacionped.anyo    = :anyo
		and    prompreparacionped.pedido  = :pedido
		and    prompreparacionped.situacion  = "P";
				IF IsNull(numero) Then numero = 0
		IF numero = 0 Then
			Delete From  prompreparacionped
			Where  prompreparacionped.empresa = :codigo_empresa
			and    prompreparacionped.anyo    = :anyo
			and    prompreparacionped.pedido  = :pedido;
			COMMIT;
		END IF
		
	This.Reset()
	This.visible= FALSE
	f_activar_campos(TRUE)
	IF sal = "S" Then
		pb_1.TriggerEvent(Clicked!)
		Return
	END IF
	f_activar_campo(uo_cliente.em_campo)
	Return
END IF
IF row = 0 Then Return
IF GetItemString(row,"tipo_unidad")= "0" Then
	SetTaborder("total_piezas",10)
	SetTaborder("cajas",0)
ELSE
	SetTaborder("cajas",10)
	SetTaborder("total_piezas",0)
END IF
SetRow(row)
IF GetItemString(row,"situacion")<>"P" Then
	IF GetItemString(row,"tipo_unidad")= "0" Then
		SetColumn("total_piezas")
	ELSE
		SetColumn("cajas")
	END IF
END IF




end event

event itemchanged;Dec cajas, total_piezas,cant
String v_caja
Accepttext()
articulo = GetItemString(row,"articulo")
v_caja   = GetItemString(row,"caja")
IF GetItemString(row,"tipo_unidad") = "0" Then
	total_piezas  = GetItemNumber(row,"total_piezas")
	cajas         =  f_calculo_total_cajas_minimo1(codigo_empresa,articulo,total_piezas,v_caja)
	SetItem(row,"cajas",cajas)
ELSE
	cajas = GetItemNumber(row,"cajas")
	total_piezas  = f_calculo_piezas_cajas(codigo_empresa,articulo,v_caja,cajas)
	SetItem(row,"total_piezas",total_piezas)
END IF





end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow = 0 Then Return
IF GetItemString(currentrow,"situacion")= "P" Then
			SetTaborder("tabulador",1)
		Setcolumn("tabulador")
		SetTaborder("cajas",0)
		SetTaborder("total_piezas",0)
Else

	IF GetItemString(currentrow,"tipo_unidad")= "0" Then
		SetTaborder("total_piezas",10)
		SetTaborder("cajas",0)
		Setcolumn("total_piezas")
	ELSE
		SetTaborder("cajas",10)
		SetTaborder("total_piezas",0)
		Setcolumn("cajas")
	END IF
	SetTaborder("tabulador",0)
END IF


end event

event doubleclicked;call super::doubleclicked;String  var_calidad,var_tipo_pallet,var_articulo
Dec{0}  var_tono,var_calibre
IF GetRow()= 0 Then Return
var_articulo    = This.GetItemString(GetRow(),"articulo") 
var_calidad     = This.GetItemString(GetRow(),"calidad")  
this.enabled = FALSE
dw_albaranes.visible = TRUE
dw_albaranes.Retrieve(codigo_empresa,var_articulo,var_calidad)


end event

type dw_pedidos from datawindow within w_preparacion_pedidos_promocion
integer x = 9
integer y = 336
integer width = 2821
integer height = 1088
string dataobject = "dw_preparacion_pedidos_promocion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;SetNUll(anyo)
SetNUll(pedido)
SetNUll(linea)
SetNUll(tono)
SetNUll(calibre)
SetNUll(orden)
SetNUll(cantidad)
SetNUll(disponible)
SetNUll(cliente)
SetNUll(tipo_cli)
SetNUll(tipo)
SetNUll(tipo_pallet)
SetNUll(articulo)
SetNUll(calidad)
SetNUll(expositor)
SetNUll(situacion)
SetNUll(panel)
SetNUll(ubicacion)
SetNUll(ser)
SetNUll(sal)

IF row=0 then Return
anyo         = dw_pedidos.GetItemNumber(row,"anyo")
pedido       = dw_pedidos.GetItemNumber(row,"pedido")
f_cargar()
end event

type dw_albaranes from datawindow within w_preparacion_pedidos_promocion
event clicked pbm_dwnlbuttonclk
event doubleclicked pbm_dwnlbuttondblclk
boolean visible = false
integer y = 340
integer width = 1952
integer height = 1080
integer taborder = 40
boolean titlebar = true
string title = "Ultimas salidas promoción"
string dataobject = "dw_int_preparacion_pedidos_promocion2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF f_objeto_datawindow(dw_ubicaciones) = "salir" Then
	dw_detalle.enabled = TRUE
	Reset()
	visible = FALSE
END IF
end event

event doubleclicked;This.visible = FALSE
dw_detalle.enabled = TRUE

end event

type st_disponible from statictext within w_preparacion_pedidos_promocion
boolean visible = false
integer x = 480
integer y = 1264
integer width = 384
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

